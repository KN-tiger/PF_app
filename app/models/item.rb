class Item < ApplicationRecord

    belongs_to :genre
    has_many :order_items
    has_many :carts

    has_many_attached :images

    validates :name, presence: true
    validates :introduction, presence: true
    validates :price_without_tax, presence: true
    validates :is_stopped, inclusion: {in: [true, false]}
    validate :image_type, :image_length

    def price_with_tax
      tax = 1 + 0.10
      ( self.price_without_tax * tax).floor
    end

    def get_image(*size)
      unless image.attached?
        file_path = Rails.root.join('app/assets/images/no-image.jpg')
        image.attach(io: File.open(file_path), filename: 'no-image.jpg', content_type: 'image/jpg')
      end
        
      if !size.empty?
        image.variant(resize: size)
      else
        image
      end
    end
    
  private
  
    def image_type
      images.each do |image|
        if !image.blob
          errors.add(:image, 'をアップロードしてください')
        elsif !image.blob.content_type.in?(%('image/jpg image/png'))
          errors.add(:image, 'はJPEGまたはPNG形式を選択してアップロードしてください')
        end
      end  
    end
    
    def image_length
      if images.length > 3
        errors.add(:images, "は3枚以内にしてください")
      end
    end
end
