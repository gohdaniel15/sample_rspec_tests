FactoryGirl.define do
  factory :reaction do
    association :user, factory: :user, strategy: :build
    association :tweet, factory: :tweet, strategy: :build

  end
end
