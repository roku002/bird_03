require 'rails_helper'

RSpec.describe Board, type: :model do
  let(:board) { create(:board) } # FactoryBotでBoardを作成

  describe 'バリデーション' do
    it 'すべての属性が有効である場合、ボードは有効である' do
      expect(board).to be_valid
    end

    it 'タイトルがない場合、無効である' do
      board.title = nil
      expect(board).not_to be_valid
    end

    it 'タイトルが255文字を超える場合、無効である' do
      board.title = 'a' * 256
      expect(board).not_to be_valid
    end

    it '本文がない場合、無効である' do
      board.body = nil
      expect(board).not_to be_valid
    end

    it '本文が最大文字数を超える場合、無効である' do
      board.body = 'a' * 65_536
      expect(board).not_to be_valid
    end
  end

  describe 'アソシエーション' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
  end
end
