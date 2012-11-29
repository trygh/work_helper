class Task < ActiveRecord::Base
  attr_accessible :content, :minutes, :project_id, :title, :url, :reported_for

  belongs_to :project
  belongs_to :user
end
