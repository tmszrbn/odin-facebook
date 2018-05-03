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
  factory :comment do
    sequence(:commentable_id) { |n| "#{n}"}
    commentable_type 'Post'
    sequence(:content) { |n| "This is content of #{n.ordinalize} comment"}
    sequence(:user_id) { |n| "#{n}" }
  end
end