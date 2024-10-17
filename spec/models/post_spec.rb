require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { create(:post) } # FactoryBotでポストを作成

  describe 'バリデーション' do
    it 'すべての属性が有効である場合、ポストは有効である' do
      expect(post).to be_valid
    end

    it 'タイトルがない場合、無効である' do
      post.title = nil
      expect(post).not_to be_valid
    end

    it 'タイトルが255文字を超える場合、無効である' do
      post.title = 'a' * 256
      expect(post).not_to be_valid
    end

    it '本文がない場合、無効である' do
      post.body = nil
      expect(post).not_to be_valid
    end

    it '本文が最大文字数を超える場合、無効である' do
      post.body = 'a' * 65_536
      expect(post).not_to be_valid
    end
  end

  describe 'アソシエーション' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
    it { is_expected.to have_many(:post_tags).dependent(:destroy) }
    it { is_expected.to have_many(:tags).through(:post_tags).dependent(:destroy) }
  end

  describe 'インスタンスメソッド' do
    let(:ruby_tag) { create(:tag, name: 'Ruby') }
    let(:rails_tag) { create(:tag, name: 'Rails') }
    let(:art_tag) { create(:tag, name: 'Art') }

    describe 'タグの関連' do
      let(:tag) { create(:tag) }

      it '投稿にタグを追加できる' do
        create(:post_tag, post:, tag:)
        expect(post.tags).to include(tag)
      end

      it '同じ投稿に同じタグを重複して追加できない' do
        create(:post_tag, post:, tag:)
        # ユニークバリデーションを確認
        expect do
          create(:post_tag, post:, tag:)
        end.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    describe '#タグ名の取得' do
      it 'タグ名をカンマで連結して返す' do
        post.tags << ruby_tag << rails_tag
        expect(post.tag_names).to eq 'Ruby,Rails'
      end
    end

    describe '#タグの保存' do
      it 'タグを保存する' do
        post.save_tags(['Ruby', 'Rails'])
        expect(post.tags.map(&:name)).to include('Ruby', 'Rails')
      end

      it '既存のタグを重複して保存しない' do
        post.tags << ruby_tag
        post.save_tags(['Ruby', 'Art'])
        expect(post.tags.map(&:name)).to include('Ruby', 'Art')
      end
    end
  end
end
