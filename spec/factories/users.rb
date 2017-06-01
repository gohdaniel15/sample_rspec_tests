FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@example.com" }
    password "123456"
    sequence(:name) { |n| "full_name#{n}" }
    contact "123123123"
    sequence(:username) { |n| "username#{n}" }

    trait :invalid do
      name nil
      email nil
      contact nil
      username nil
    end
  end
end
