class Task < ActiveRecord::Base
  attr_accessible :content, :minutes, :project_id, :title, :url, :published_on

  belongs_to :project
  belongs_to :user
end
