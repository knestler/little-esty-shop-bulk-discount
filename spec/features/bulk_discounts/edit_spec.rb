require 'rails_helper'

RSpec.describe 'bulk discount edit page' do
  let!(:nomi) {Merchant.create!(name: "Naomi LLC")}
  let!(:tyty) {Merchant.create!(name: "TyTy's Grub")}
  
  let!(:timmy) {Customer.create!(first_name: "Timmy", last_name: "Limmy")}
  let!(:sue) {Customer.create!(first_name: "Sue", last_name: "Maybis")}
  let!(:shooter) {Customer.create!(first_name: "Shooter", last_name: "Mcgavin")}
  let!(:louise) {Customer.create!(first_name: "Louise", last_name: "Banks")}
  let!(:alfred) {Customer.create!(first_name: "Alfred", last_name: "Borden")}
  let!(:olivia) {Customer.create!(first_name: "Olivia", last_name: "Wenscombe")}
  
  let!(:item_1) {nomi.items.create!(name: "Book", description: "book", unit_price: 11)}
  let!(:item_2) {nomi.items.create!(name: "Big Book", description: "bigger book", unit_price: 11)}
  let!(:stickers) {nomi.items.create!(name: "Anime Stickers", description: "Random One Piece and Death Note stickers", unit_price: 599)}
  let!(:lamp) {nomi.items.create!(name: "Lava Lamp", description: "Special blue/purple wax inside a glass vessel", unit_price: 2000)}
  let!(:orion) {nomi.items.create!(name: "Orion Flag", description: "A flag of Okinawa's most popular beer", unit_price: 850)}
  let!(:oil) {tyty.items.create!(name: "Special Chili Oil", description: "Random One Piece and Death Note stickers", unit_price: 800)}
  let!(:water) {tyty.items.create!(name: "The Best Water Ever", description: "from the great Cherry Creek Reservoir", unit_price: 100)}
  let!(:shirt) {tyty.items.create!(name: "Funny Shirt", description: "nice", unit_price: 1099)}
  let!(:pants) {tyty.items.create!(name: "Pants", description: "nice", unit_price: 2010)}
  
  let!(:invoice_1) {Invoice.create!(status: 2, customer_id: timmy.id)}
  let!(:invoice_2) {Invoice.create!(status: 2, customer_id: timmy.id)}
  let!(:invoice_3) {Invoice.create!(status: 2, customer_id: sue.id)}
  let!(:invoice_4) {Invoice.create!(status: 2, customer_id: sue.id)}
  let!(:invoice_5) {Invoice.create!(status: 2, customer_id: shooter.id)}
  let!(:invoice_6) {Invoice.create!(status: 2, customer_id: shooter.id)}
  let!(:invoice_7) {Invoice.create!(status: 2, customer_id: louise.id)}
  let!(:invoice_8) {Invoice.create!(status: 2, customer_id: louise.id)}
  let!(:invoice_9) {Invoice.create!(status: 2, customer_id: alfred.id)}
  let!(:invoice_10) {Invoice.create!(status: 2, customer_id: alfred.id)}
  let!(:invoice_11) {Invoice.create!(status: 2, customer_id: olivia.id)}
  let!(:invoice_12) {Invoice.create!(status: 2, customer_id: olivia.id)}
  let!(:invoice_13) {Invoice.create!(status: 2, customer_id: shooter.id)}
  
  let!(:invoice_item_1) {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 2, unit_price: 11, status: "packaged")}
  let!(:invoice_item_2) {InvoiceItem.create!(item_id: lamp.id, invoice_id: invoice_3.id, quantity: 2, unit_price: 11, status: "packaged")}
  let!(:invoice_item_3) {InvoiceItem.create!(item_id: orion.id, invoice_id: invoice_5.id, quantity: 2, unit_price: 11, status: "packaged")}
  let!(:invoice_item_4) {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_7.id, quantity: 2, unit_price: 11, status: "packaged")}
  let!(:invoice_item_5) {InvoiceItem.create!(item_id: stickers.id, invoice_id: invoice_9.id, quantity: 2, unit_price: 11, status: "packaged")}
  let!(:invoice_item_6) {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_11.id, quantity: 2, unit_price: 11, status: "pending")}
  let!(:invoice_item_7) {InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_13.id, quantity: 1, unit_price: 11, status: "pending")}
  
  let!(:transaction_1) {Transaction.create!(credit_card_number: 1111111111111111, credit_card_expiration_date: "11/11", result: "success", invoice_id: invoice_1.id)}
  let!(:transaction_2) {Transaction.create!(credit_card_number: 1111111111111111, credit_card_expiration_date: "11/11", result: "success", invoice_id: invoice_2.id)}
  let!(:transaction_3) {Transaction.create!(credit_card_number: 2222222222222222, credit_card_expiration_date: "01/11", result: "success", invoice_id: invoice_3.id)}
  let!(:transaction_4) {Transaction.create!(credit_card_number: 2222222222222222, credit_card_expiration_date: "01/11", result: "success", invoice_id: invoice_4.id)}
  let!(:transaction_5) {Transaction.create!(credit_card_number: 3333333333333333, credit_card_expiration_date: "01/21", result: "success", invoice_id: invoice_5.id)}
  let!(:transaction_6) {Transaction.create!(credit_card_number: 3333333333333333, credit_card_expiration_date: "01/21", result: "success", invoice_id: invoice_6.id)}
  let!(:transaction_7) {Transaction.create!(credit_card_number: 1555555555555555, credit_card_expiration_date: "01/21", result: "success", invoice_id: invoice_7.id)}
  let!(:transaction_8) {Transaction.create!(credit_card_number: 1555555555555555, credit_card_expiration_date: "01/21", result: "success", invoice_id: invoice_8.id)}
  let!(:transaction_9) {Transaction.create!(credit_card_number: 1000000000000000, credit_card_expiration_date: "01/21", result: "success", invoice_id: invoice_9.id)}
  let!(:transaction_10) {Transaction.create!(credit_card_number: 1000000000000000, credit_card_expiration_date: "01/21", result: "success", invoice_id: invoice_10.id)}
  let!(:transaction_11) {Transaction.create!(credit_card_number: 2000000000000000, credit_card_expiration_date: "01/21", result: "success", invoice_id: invoice_11.id)}
  let!(:transaction_12) {Transaction.create!(credit_card_number: 2000000000000000, credit_card_expiration_date: "01/21", result: "failed", invoice_id: invoice_12.id)}
  let!(:transaction_13) {Transaction.create!(credit_card_number: 3333333333333333, credit_card_expiration_date: "01/21", result: "success", invoice_id: invoice_13.id)}

  let!(:bulk_discount_1) {nomi.bulk_discounts.create!(percentage_discount: 10, quantity_threshold: 10) }
  let!(:bulk_discount_2) {nomi.bulk_discounts.create!(percentage_discount: 15, quantity_threshold: 5) }
  let!(:bulk_discount_3) {tyty.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10) }
  let!(:bulk_discount_4) {tyty.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 15) }
  
  describe 'bulk discount edit page' do
    it ' shows a form with existing bulk discount attributes' do
      visit edit_merchant_bulk_discount_path(nomi, bulk_discount_1)
      
      expect(page).to have_content("Id: #{bulk_discount_1.id}")
      expect(page).to have_field(:percentage_discount, with: bulk_discount_1.percentage_discount)
      expect(page).to have_field(:quantity_threshold, with: bulk_discount_1.quantity_threshold)
    end
    
    it "redirects back to bulk discounts show page with updated info" do
      visit edit_merchant_bulk_discount_path(nomi, bulk_discount_1)
      fill_in :percentage_discount, with: 25
      fill_in :quantity_threshold, with: " "
      click_button "Update Discount"

      expect(current_path).to eq("/merchants/#{nomi.id}/bulk_discounts/#{bulk_discount_1.id}/edit")
      expect(page).to have_content("Fields can't be left blank")

      fill_in :percentage_discount, with: 30
      fill_in :quantity_threshold, with: 50
      click_button "Update Discount"
      
      expect(current_path).to eq("/merchants/#{nomi.id}/bulk_discounts/#{bulk_discount_1.id}")
      expect(page).to have_content("Naomi LLC")
      expect(page).to_not have_field("Name", with: tyty.id)
      expect(page).to have_content(bulk_discount_1.id)
      expect(page).to have_content("Percentage Discount: 30")
      expect(page).to have_content("Quantity Needed: 50")
    end

  end
end