FactoryBot.define do
  factory :showtime do
    price { 20.91 }
    starts_at { 2.days.from_now }
    association :movie, factory: :movie
  end
end
