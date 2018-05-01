FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user#{n}"}
    email { |n| "user#{n}@example.com" }
    password 'password'
  end
end