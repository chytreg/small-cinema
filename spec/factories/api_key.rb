FactoryBot.define do
  factory :api_key do
    sequence(:token_digest) { SecureRandom.hex }
    association :bearer, factory: :user
  end
end
