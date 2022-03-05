class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_many :transactions, through: :invoice
  has_many :discounts, through: :item

  validates_presence_of :quantity
  validates_presence_of :unit_price
  validates_presence_of :status


  enum status: { "packaged" => 0, "pending" => 1, "shipped" => 2 }
end
