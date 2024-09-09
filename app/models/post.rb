class Post < ApplicationRecord
  mount_uploader :image, PostUploader

  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, dependent: :destroy

  def tag_names
    tags.map(&:name).join(",")
  end

  def save_tags(tag_names)
    tag_names.each do |tag_name|
      tag = Tag.find_or_initialize_by(name: tag_name.strip)

      unless self.tags.include?(tag)
        self.tags << tag
      end
    end
  end
end
