class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :tag_relations, dependent: :destroy

  validates :name, length: { in: 1..15 }, uniqueness: true
end
