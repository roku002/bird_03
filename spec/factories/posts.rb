FactoryBot.define do
  factory :post do
    title { "テスト" }
    body { "テストになります。" }
    association :user # 投稿に関連するユーザーを生成
  end
end
