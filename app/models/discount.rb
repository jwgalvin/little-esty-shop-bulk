class Discount < ApplicationRecord
  belongs_to :merchant

  validates_presence_of :name, :percent, :threshold
  validates :threshold, numericality: {only_integer: true}
end
