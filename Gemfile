source 'https://rubygems.org'

gem 'rails', '3.2.11'

gem 'mysql2'
gem 'haml-rails'
gem 'prawn', :git => 'git://github.com/prawnpdf/prawn.git'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby
  gem "twitter-bootstrap-rails"
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'less-rails'
gem 'jquery-ui-rails'

gem 'country-select'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

gem 'devise'

gem 'activeadmin'

group :development do
  gem 'capistrano', :require => nil
  gem 'rvm-capistrano', :require => nil
  gem 'guard'
  gem 'guard-livereload'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'database_cleaner'
end

group :test do
  gem "factory_girl_rails", :require => nil
end
