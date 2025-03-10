require 'rails_helper'

RSpec.describe 'Shows 1 invoice, and all its attributes', type: :feature do
  before do
    @merchant1 = Merchant.create!(name: "The Tornado")
    @merchant2 = Merchant.create!(name: "The Cornado")
    @item1 = @merchant1.items.create!(name: "SmartPants", description: "IQ + 20", unit_price: 125)
    @item2 = @merchant1.items.create!(name: "Smartshirt", description: "IQ + 20", unit_price: 250)
    @customer1 = Customer.create!(first_name: "Marky", last_name: "Mark" )
    @customer2 = Customer.create!(first_name: "Larky", last_name: "Lark" )
    @customer3 = Customer.create!(first_name: "Sparky", last_name: "Spark" )
    @invoice1 = @customer1.invoices.create!(status: 1)
    @invoice2 = @customer2.invoices.create!(status: 1)
    @invoice3 = @customer2.invoices.create!(status: 1)
    @invoice_item1 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item1.id, quantity: 2, unit_price: 125, status: 1)
    @invoice_item2 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item2.id, quantity: 10, unit_price: 250, status: 1)
    @discount1 = @merchant1.discounts.create!(name: "Floppies bday", threshold: 10, percent:5)
    @discount2 = @merchant1.discounts.create!(name: "Moppies bday", threshold: 15, percent:7)
    @discount3 = @merchant1.discounts.create!(name: "Troppies bday", threshold: 20, percent:10)
    @discount4 = @merchant2.discounts.create!(name: "Cloppies bday", threshold: 25, percent:15)
  end

  it "links from the merchants/invoices index to merch/inv/show" do
    visit "/merchants/#{@merchant1.id}/invoices"

    click_link("Invoice Number: #{@invoice1.id}")

    expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}")
  end

  it "lists all the attributes for a single invoice." do
    visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

    expect(page).to have_content("#{@invoice1.id}")
    expect(page).to have_content("Customer name: #{@invoice1.customer.first_name} #{@invoice1.customer.last_name}")
    expect(page).to have_content("Customer ID: #{@invoice1.customer.id}")
    expect(page).to have_content("Invoice status: #{@invoice1.status}")
    expect(page).to have_content("#{@invoice1.created_at.strftime("%A, %B %d, %Y")}")
  end

  it 'lists information for each item on invoice' do
    visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

    expect(page).to have_content("Item name: #{@item1.name}")
    expect(page).to have_content("Item price: $1.25")
    expect(page).to have_content("Quantity purchased: #{@invoice_item1.quantity}")
    expect(page).to have_content("Item status: #{@invoice_item1.status}")
  end

  it 'does not display items from other merchants' do
    other_merchant = create(:merchant)
    other_item = create(:item, merchant: other_merchant)

    visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

    expect(page).not_to have_content(other_item.name)
  end

  it "can update status via dropdown menu's" do
    visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

    within "##{@invoice_item1.item_id}" do
      select'shipped', from: :status
      click_button("Update Item Status")
    end
      expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}")
    within("##{@invoice_item1.item_id}") do
      expect(page).to have_content("Item status: shipped")
      select'shipped', from: :status
      click_button("Update Item Status")
      expect(page).to have_content("Item status: shipped")
      expect(page).to_not have_content("Item status: pending")
      expect(page).to_not have_content("Item status: packaged")
    end

    within("##{@invoice_item1.item_id}") do
      select'pending', from: :status
      click_button("Update Item Status")
      expect(page).to have_content("Item status: pending")
      expect(page).to_not have_content("Item status: shipped")
      expect(page).to_not have_content("Item status: packaged")
    end

    within("##{@invoice_item1.item_id}") do
      select'packaged', from: :status
      click_button("Update Item Status")
      expect(page).to have_content("Item status: packaged")
      expect(page).to_not have_content("Item status: shipped")
      expect(page).to_not have_content("Item status: pending")
    end
  end

  it " test for the total amount of the invoice." do
    visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"
    # 27.50 = (2x125)+(10x250)
    #discount 1.25 = 5%x 2500
    #owed 26.25
    expect(page).to have_content("Amount before promotions: $27.5")
    expect(page).to have_content("Amount discounted: $1.25")
    expect(page).to have_content("Total invoice amount: $26.25")
  end

  it "has a button to the discounts applied" do
    visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"
    within("##{@invoice_item2.item_id}") do
      click_button("#{@discount1.name}")
      expect(current_path).to eq("/merchants/#{@merchant1.id}/discounts/#{@discount1.id}")
    end

  end

end
