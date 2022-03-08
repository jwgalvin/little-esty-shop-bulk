class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  validates_presence_of :status

  enum status: { "in progress" => 0, "cancelled" => 1, "completed" => 2 }


  def total_revenue
    invoice_items.sum('unit_price * quantity')
  end

  def self.incomplete
    #self.where.not(status: 1).joins(:invoice_items).where.not(status: 2).group("invoices.id")
    where(status: 0).order(:created_at)
  end

  def dis_counter
    invoice_items.joins(:discounts)
    .select('invoice_items.id, MAX((invoice_items.unit_price * invoice_items.quantity)* (discounts.percent /100.00)) AS applied_discount')
    .where('invoice_items.quantity >= discounts.threshold')
    .group('invoice_items.id')
    .sum(&:applied_discount)
  end

end
