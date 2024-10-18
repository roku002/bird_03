FactoryBot.define do
  factory :board do
    title { "テストボード" }
    body { "これはテストボードの本文です。" }
    board_image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/tori.jpg'), 'image/jpeg') }
    association :user # ユーザーとの関連を生成
  end
end
