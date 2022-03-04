require 'rails_helper'

RSpec.describe Discount, type: :model do
  describe "relationship" do

    it {should belong_to :merchant}
  end

  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :percent}
    it {should validate_presence_of :threshold}
  end
end
