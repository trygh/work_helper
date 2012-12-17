class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :first_name, :last_name
  # attr_accessible :title, :body

  has_one :dev_profile, dependent: :delete
  has_many :task_reports
  #participant relatioships
  has_many :participants, :dependent => :destroy
  has_many :projects, through: :participants
  has_many :owned_projects, through: :participants, source: :project, conditions: 'participants.role_id = ' +
      Participant::Role::OWNER.to_s

  def name
    "#{first_name} #{last_name}"
  end

  after_create do
    dev_profile.create
  end
end
