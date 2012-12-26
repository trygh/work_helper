class Worker < ActiveRecord::Base
  attr_accessible :buyer_id, :hourly_rate, :seller_id, :user_id

  belongs_to :seller, class_name: "Company", foreign_key: 'seller_id'
  belongs_to :buyer, class_name: "Company", foreign_key: 'buyer_id'
  belongs_to :user
end
