require 'spec_helper'

describe ProjectsReport do
  it "should calculate projects summary" do
    pending("finish when devise error will be fixed")
    project1 = create :project
    project2 = create :project
    vitalie = create :user
    alex = create :user
    create :dev_profile, user: vitalie, ext_hourly_rate: 30
    create :dev_profile, user: alex, ext_hourly_rate: 50 # in 2018

    [project1, project2].each do |project|
      [vitalie, alex].each do |user|
        2.times do |idx|
          create :task_report, user: user, project: project, minutes: (30+10*idx)
        end
      end
    end
    report = ProjectsReport.new([project1.id, project2.id], Date.today.beginning_of_month)
    report.projects_summary.should == {}
  end
end
