FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@smallcinema.com" }
    password { "P@ssw0rd!" }
    trait :owner do
      role { "owner" }
    end
  end
end
