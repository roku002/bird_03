require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) } # FactoryBotでユーザーを作成

  describe 'バリデーション' do
    it 'すべての属性が有効である場合、ユーザーは有効である' do
      expect(user).to be_valid
    end

    it 'メールアドレスがない場合、無効である' do
      user.email = nil
      expect(user).not_to be_valid
    end

    it '名前がない場合、無効である' do
      user.name = nil
      expect(user).not_to be_valid
    end

    it 'パスワードが3文字未満の場合、無効である' do
      user.password = '12'
      expect(user).not_to be_valid
    end

    it 'パスワード確認が一致しない場合、無効である' do
      user = FactoryBot.build(:user, password_confirmation: "different_password")
      expect(user).not_to be_valid
    end
  end

  describe 'アソシエーション' do
    it { is_expected.to have_many(:posts).dependent(:destroy) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
    it { is_expected.to have_many(:like_posts).through(:likes).source(:post) }
    it { is_expected.to have_many(:boards).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
  end

  describe 'インスタンスメソッド' do
    let(:post) { create(:post) }

    it 'ユーザーがオブジェクトを所有しているかどうかを確認する' do
      expect(user.own?(post)).to be false
    end

    it '投稿を「いいね」する' do
      user.like(post)
      expect(user.like?(post)).to be true
    end

    it '投稿の「いいね」を解除する' do
      user.like(post)
      user.unlike(post)
      expect(user.like?(post)).to be false
    end
  end
end
