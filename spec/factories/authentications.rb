FactoryBot.define do
  factory :authentication do
    provider { "google" }  # ソーシャルログインのプロバイダー名（例: google, facebookなど）
    uid { "123456789" }    # プロバイダーから提供されるユーザーID
    association :user # `user` モデルとの関連を指定
  end
end
