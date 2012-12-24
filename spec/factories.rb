FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  sequence :username do |n|
    "robot#{n}"
  end

  sequence :first_name do |n|
    "first_name#{n}"
  end

  sequence :last_name do |n|
    "last_name#{n}"
  end

  sequence :project_name do |n|
    "SuperName#{n}"
  end

  sequence :website do |n|
    "http://test#{n}.info"
  end

  factory :user do
    username { generate(:username) }
    email { generate(:email) }
    first_name { generate(:first_name) }
    last_name { generate(:last_name) }
  end

  factory :project do
    name { generate :project_name }
  end

  factory :task_report do
    minutes 30
    url { generate :website }
    title { "Report for " + generate(:project_name) }
    reported_for Date.today
  end

  factory :dev_profile do
    hourly_rate 5
    ext_hourly_rate 10
  end
end
