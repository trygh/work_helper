class Company < ActiveRecord::Base
  attr_accessible :name

  # has_many :comments, as: :commentable
  has_many :workers, dependent: :delete_all, foreign_key: 'buyer_id'
  has_many :projects, dependent: :delete_all
end
