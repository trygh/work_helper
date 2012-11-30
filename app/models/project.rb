class Project < ActiveRecord::Base
  attr_accessible :name, :url

  has_many :task_reports
end
