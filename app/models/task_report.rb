class TaskReport < ActiveRecord::Base
  attr_accessible :content, :minutes, :project_id, :title, :url, :reported_for, :user_id

  belongs_to :project
  belongs_to :user

  validates_presence_of :reported_for, :title, :project_id, :minutes
end
