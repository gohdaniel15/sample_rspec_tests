FactoryGirl.define do
  factory :relationship do
    association :followed, factory: :user, strategy: :build
    association :follower, factory: :user, strategy: :build

  end
end
