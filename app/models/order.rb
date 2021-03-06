class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items

  validates :amount, presence: true
  validates :user_id, presence: true
  validates :status, presence: true

  enum status: %w(Ordered Paid Cancelled Completed)

  def add_order_items(cart)
    cart.contents.each do |item_id, qty|
      item = Item.find(item_id)
      self.order_items.create(item_id: item_id, quantity: qty, sub_total: item.price * qty)
    end
  end
end
