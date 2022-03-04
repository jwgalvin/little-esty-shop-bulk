require 'rails_helper'

describe "Merchant Dashboard", type: :feature do
  before do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)

    @discount1 = @merchant1.discounts.create!(name: "Floppies bday", threshold: 10, percent:5)
    @discount2 = @merchant1.discounts.create!(name: "Moppies bday", threshold: 15, percent:7)
    @discount3 = @merchant1.discounts.create!(name: "Troppies bday", threshold: 20, percent:10)

    @discount4 = @merchant2.discounts.create!(name: "Cloppies bday", threshold: 25, percent:15)
  end


  it "starts at the merchants dashboard and clicks the discount links" do
    visit "/merchants/#{@merchant1.id}"

    click_button("Promotions")
    expect(current_path).to eq("/merchants/#{@merchant1.id}/discounts")
  end

  it "has an discount index page that only lists 1 merchants promotions." do
    visit "/merchants/#{@merchant1.id}/discounts"


    expect(page).to have_content(@discount1.name)
    expect(page).to have_content(@discount2.name)
    expect(page).to have_content(@discount3.name)
    expect(page).to_not have_content(@discount4.name)
  end

  it "Lists all 3 attributes for each promo." do
    visit "/merchants/#{@merchant1.id}/discounts"


    expect(page).to have_content(@discount1.name)
    expect(page).to have_content(@discount1.threshold)
    expect(page).to have_content(@discount1.percent)
  end

  it "discount index to discount show" do
    visit "/merchants/#{@merchant1.id}/discounts"
    within("##{@discount1.id}") do
      click_button("View promotion")
    end
    expect(current_path).to eq("/merchants/#{@merchant1.id}/discounts/#{@discount1.id}")
  end
end
