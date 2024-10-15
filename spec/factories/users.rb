FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" } # 一意のメールアドレスを生成
    name { "Test User" }
    password { "password" }
    password_confirmation { "password" }
  end
end
