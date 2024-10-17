FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "Tag#{n}" } # 一意のタグ名を生成
  end
end
