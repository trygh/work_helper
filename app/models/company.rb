class Company < ActiveRecord::Base
  attr_accessible :name

  has_many :comments, as: :commentable

end
