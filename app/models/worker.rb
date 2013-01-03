class Worker < ActiveRecord::Base
  attr_accessible :buyer_id, :hourly_rate, :seller_id, :user_id,
                  :buyer, :seller, :user

  belongs_to :seller, class_name: "Company", foreign_key: 'seller_id'
  belongs_to :buyer, class_name: "Company", foreign_key: 'buyer_id'
  belongs_to :user
  has_many :participants
  has_many :projects, through: :participants

  def user_name
    user.first_name + ' ' + user.last_name
  end

  def user_email
    user.email
  end
end
