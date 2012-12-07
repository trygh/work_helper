class Participant < ActiveRecord::Base
  attr_accessible :ext_hrate, :project_id, :role_id, :state, :user_id

  belongs_to :user
  belongs_to :project

  ROLE = { 'owner' =>100, 'manager' => 80, 'agent' => 70, 'worker' => 50 }

  class Role
    ROLE.each do |key, value|
      const_set(key.upcase, value)
    end
  end

  scope :owner_role, where(:role_id => Role::OWNER)
  scope :manager_role, where(:role_id => Role::MANAGER)
  scope :agent_role, where(:role_id => Role::AGENT)
  scope :worker_role, where(:role_id => Role::WORKER)

end
