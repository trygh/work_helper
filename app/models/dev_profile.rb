class DevProfile < ActiveRecord::Base
  attr_accessible :hourly_rate, :github, :twitter, :gsm, :facebook, as: :default
  attr_accessible :ext_hourly_rate, as: :manager
  belongs_to :user
end
