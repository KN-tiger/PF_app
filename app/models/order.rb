class Order < ApplicationRecord

  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items

  validates :name, presence: true
  validates :postage, presence: true
  validates :total_payment, presence: true

  enum order_status: { waiting: 0, paid_up: 1, making: 2, preparing: 3, shipped: 4 }

end
  
