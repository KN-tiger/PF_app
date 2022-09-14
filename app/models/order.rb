class Order < ApplicationRecord

  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items

  validates :delivery, presence: true
  validates :deadline, presence: true
  validates :total_payment, presence: true
  validates :payment_method, presence: true

  enum order_status: { ordered: 0, waiting_arrival: 1, arrived: 2, complete: 3 }
  enum payment_method: { cash: 0, credit_card: 1, bank_transfer: 2, electronic_money: 3 }

end

