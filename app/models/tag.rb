class Tag < ApplicationRecord
  
  has_many :item_s, dependent: :destroy
  
end
