class Item < ApplicationRecord

  belongs_to :genre
  has_many :order_items, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :item_tags, dependent: :destroy
  has_many :tags, through: :item_tags, dependent: :destroy

  has_one_attached :image

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price_without_tax, presence: true
  validates :is_stopped, inclusion: {in: [true, false]}
  validate :image_type



  def price_with_tax
    tax = 1 + 0.10
    ( self.price_without_tax * tax).floor
  end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  def save_tags(save_item_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - save_item_tags
    new_tags = save_item_tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(tag_name: old_name)
    end

    new_tags.each do |new_name|
      item_tag = Tag.find_or_create_by(tag_name: new_name)
      self.tags << item_tag
    end
  end

  def self.search(word)
    if word != ""
      Item.eager_load(:tags).where(['name LIKE ? OR introduction LIKE ? OR tags.tag_name LIKE ?', "%#{word}%", "%#{word}%", "%#{word}%" ])
      #部分一致で検索
    else
      Item.order('created_at DESC')
    end
  end

private

  def image_type
    if !image.blob
      errors.add(:image, 'をアップロードしてください')
    elsif !image.blob.content_type.in?(%('image/jpeg image/png'))
      errors.add(:image, 'はJPEGまたはPNG形式を選択してアップロードしてください')
    end
  end

end
