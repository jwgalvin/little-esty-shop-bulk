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


  it "starts at the merchants dashboard and clicks the discout links" do
    visit "/merchants/#{@merchant1.id}/discounts"

    click_button("Create new promotion")
    expect(current_path).to eq("/merchants/#{@merchant1.id}/discounts/new")
  end

  it "form for creating new promotions and takes valid inputs" do
    visit "/merchants/#{@merchant1.id}/discounts/new"

    fill_in 'name',  with: "parcheesy discount"
    fill_in 'threshold', with: '5'
    fill_in 'percent', with: "10"
    click_button("Submit")

    expect(page).to have_content("parcheesy discount")
    expect(page).to have_content("Quantity needed: 5")
    expect(page).to have_content("Percent off: 10")

  end


  it "tests for edge cases blank inputs" do
    visit "/merchants/#{@merchant1.id}/discounts/new"


    #
    fill_in 'threshold', with: '5'
    fill_in 'percent', with: "10"
    click_button("Submit")

    expect(page).to have_content("Error: Name can't be blank")
    expect(page).to_not have_content("parcheesy discount")
    expect(page).to_not have_content("Quantity needed: 5")
    
  end

  it "tests for edge cases symbols" do
    visit "/merchants/#{@merchant1.id}/discounts/new"


    fill_in 'name',  with: "parcheesy discount"
    fill_in 'threshold', with: '5'
    fill_in 'percent', with: "%"
    click_button("Submit")
    expect(page).to have_content("Error: Percent is not a number")
    expect(page).to_not have_content("parcheesy discount")
    expect(page).to_not have_content("Quantity needed: 5")
    expect(page).to_not have_content("Percent off: 10%")
  end
  #save_and_open_page
end
