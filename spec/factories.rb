FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user#{n}"}
    email { |n| "user#{n}@example.com" }
    password 'password'
  end
  factory :post do
    sequence(:title) { |n| "Title of #{n} post"}
    sequence(:content) { |n| "Content of #{n} post"}
    user
  end
end