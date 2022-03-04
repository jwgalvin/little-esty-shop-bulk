require 'rails_helper'

describe "discount show/Dashboard", type: :feature do
  before do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)

    @discount1 = @merchant1.discounts.create!(name: "Floppies bday", threshold: 10, percent:5)
    @discount2 = @merchant1.discounts.create!(name: "Moppies bday", threshold: 15, percent:7)
    @discount3 = @merchant1.discounts.create!(name: "Troppies bday", threshold: 20, percent:10)
    @discount4 = @merchant2.discounts.create!(name: "Cloppies bday", threshold: 25, percent:15)
  end

  it "has a show page that lists all attributes" do
    visit "/merchants/#{@merchant1.id}/discounts/#{@discount1.id}"

    expect(page).to have_content("Floppies bday")
    expect(page).to have_content("Quantity needed: 10")
    expect(page).to have_content("Percent off: 5")

  end
  end
