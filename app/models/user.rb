class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :first_name, :last_name
  # attr_accessible :title, :body

  has_one :dev_profile, dependent: :delete
  has_many :task_reports
  has_many :authentications
  #participant relatioships
  has_many :participants, :dependent => :destroy
  has_many :projects, through: :participants
  has_many :owned_projects, through: :participants, source: :project, conditions: 'participants.role_id = ' +
      Participant::Role::OWNER.to_s

  def name
    "#{first_name} #{last_name}"
  end

  after_create do
    prof = DevProfile.new
    prof.user = self
    prof.save!
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email  = auth.info.email
      user.first_name = auth.info.name.split(" ")[0]
      user.last_name = auth.info.name.split(" ")[1]
      user.name  = auth.info.name
      user.username = auth.info.nickname
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def email_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
end
