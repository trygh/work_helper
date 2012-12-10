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

  sequence :campaign_name do |n|
    "SuperName#{n}"
  end

  sequence :website do |n|
    "http://test#{n}.info"
  end

  factory :user do
    email { generate(:email) }
    full_name { generate(:first_name) + ' ' + generate(:last_name) }
  end
end
