class OrderItem < ApplicationRecord
  
 belongs_to :order
 belongs_to :item
 
  def sub_total
    self.price_with_tax * self.amount
  end
  
  enum provision_status: { unable: 0, arranged: 1, arrived: 2, complete: 3 }
  
end
