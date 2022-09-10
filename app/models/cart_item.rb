class CartItem < ApplicationRecord
  belongs_to :user
  belongs_to :item

  def subtotal
    item.price_with_tax * amount
  end

  def max_amount
    if self.amount < 20
      return 20
    else
      return self.amount
    end
  end

end
