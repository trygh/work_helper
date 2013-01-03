class Project < ActiveRecord::Base
  attr_accessible :name, :url, :company_id

  has_many :task_reports
  has_many :participants, dependent: :destroy
  has_many :users, through: :participants
  has_many :workers, through: :participants
  belongs_to :company

  def create_owner(user)
    participants.create(user_id: user.id, role_id: Participant::Role::OWNER)
  end
end
