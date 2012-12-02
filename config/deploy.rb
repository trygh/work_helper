require 'rvm/capistrano'
require 'bundler/capistrano'

set :application, "whelper"

set :bundle_flags, "--deployment --no-color"
set :bundle_roles, :app
set :rake, 'rake --trace'
set :rvm_type, :root

# p286 has falcon patch
set :rvm_ruby_string, "ruby-1.9.3-p286@#{application}"

set :etc_path, "/etc/#{application}"
set :deploy_to, "/home/www/#{application}"
set :repository, "git://github.com/CMEP/work_helper.git"

set :scm, :git
set :deploy_via, :remote_cache

# set :branch, (ENV['prod'] ? 'master' : 'develop')

set :user, 'rails'
set :www_user, user

ssh_options[:port] = 12222
ssh_options[:keys] = %W{rsa dsa}.map {|alg| ENV['HOME'] + "/.ssh/id_#{alg}"}

host = 'debian.md'

role :web, host
role :app, host
role :db, host, :primary => true # This is where Rails migrations will run

before 'deploy:rollback', 'deploy:stop_rollback'
before 'deploy:assets:precompile', "deploy:symlink_config"
# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

after "deploy:setup", "deploy:fix_setup_perms"

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

namespace :deploy do
  # task to override default action to avoid rollback, remove last underscores
  task :update_code__, :except => { :no_release => true } do
    #on_rollback { run "rm -rf #{release_path}; true" }
    strategy.deploy!
    finalize_update
  end

   task :start do
     run "#{try_sudo} sv start whelper"
   end
   task :stop do
     run "#{try_sudo} sv stop whelper"
   end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} sv restart whelper"
   end

  task :symlink_config do
    cmds = []

    %w{database settings_local}.each do |f|
      cmds << "cd #{release_path}/config && ln -sf #{etc_path}/#{f}.yml"
    end
    cmds << "chown #{www_user}:#{www_user} #{release_path}/tmp"
    cmds << "chown #{www_user}:#{www_user} #{release_path}/config/environment.rb"

    run cmds * " && "
  end

  task :fix_setup_perms do
    run "#{try_sudo} chown -R #{www_user} #{deploy_to}"
  end
end
