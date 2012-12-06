class Project < ActiveRecord::Base
  attr_accessible :name, :url, :user

  has_many :task_reports
  has_many :participants, dependent: :destroy
  has_many :users, through: :participants

  # define a hook method - It will be called before Rails attempts to destroy a row in the database
  before_destroy :ensure_not_referenced_by_any_participant

  private
    # ensure that there are no participants referencing this project
    def ensure_not_referenced_by_any_participant
      if participants.empty?
        return true
      else
        errors.add(:base, 'Participants present')
        return false
      end
    end

  def create_owner(user)
    participants.create(user_id: user.id, role_id: Participant::Role::OWNER)
  end
end
