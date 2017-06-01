FactoryGirl.define do
  factory :tweet do
    association :user, factory: :user, strategy: :build
    sequence(:content) { |n| "content#{n}" }

    trait :invalid do
      content nil
    end
  end
end
