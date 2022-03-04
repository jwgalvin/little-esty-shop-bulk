class Discount < ApplicationRecord
  belongs_to :merchant

  validates_presence_of :name, :percent, :threshold
  validates :percent, numericality: {only_integer: true}
  validates :threshold, numericality: {only_integer: true}
end
