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


  it "has a link to edit the promotion." do
    visit "/merchants/#{@merchant1.id}/discounts/#{@discount1.id}"

    click_button("Update Promotion")
    expect(current_path).to eq("/merchants/#{@merchant1.id}/discounts/#{@discount1.id}/edit")
  end

  it 'has the edit form and can submit the changes' do
    visit "/merchants/#{@merchant1.id}/discounts/#{@discount1.id}/edit"

    fill_in 'name',  with: "parcheesy discount"
    fill_in 'threshold', with: '5'
    fill_in 'percent', with: "10"
    click_button("Submit")


    expect(page).to have_content("parcheesy discount promotion page")
    expect(page).to have_content("Threshold quantity to qualify: 5")
    expect(page).to have_content("Percent discount applied: 10")
  end

  it "tests for edge cases symbols" do
    visit "/merchants/#{@merchant1.id}/discounts/#{@discount1.id}/edit"

    fill_in 'name',  with: "parcheesy discount"
    fill_in 'threshold', with: '5'
    fill_in 'percent', with: "10%"
    click_button("Submit")


    expect(page).to have_content("Error: Percent is not a number")
    expect(current_path).to eq("/merchants/#{@merchant1.id}/discounts/#{@discount1.id}/edit")
  end

  it "tests for edge cases empty fields" do
    visit "/merchants/#{@merchant1.id}/discounts/#{@discount1.id}/edit"

    fill_in 'name',  with: "parcheesy discount"

    fill_in 'percent', with: "10"
    click_button("Submit")

    expect(page).to have_content("Error: Threshold can't be blank, Threshold is not a number")
    expect(current_path).to eq("/merchants/#{@merchant1.id}/discounts/#{@discount1.id}/edit")
  end

end
