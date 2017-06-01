FactoryGirl.define do
  factory :reply do
    association :user, factory: :user, strategy: :build
    association :tweet, factory: :tweet, strategy: :build
    sequence(:content) { |n| "content#{n}" }

    trait :invalid do
      content nil
    end
  end
end
