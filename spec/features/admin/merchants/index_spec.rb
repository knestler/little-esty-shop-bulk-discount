require "rails_helper"

RSpec.describe "admin merchant index page" do
  before :each do
    @merchant_1 = Merchant.create!(name: "Shawn LLC")
    @merchant_2 = Merchant.create!(name: "Naomi LLC")
    @merchant_3 = Merchant.create!(name: "Kristen LLC")
    @merchant_4 = Merchant.create!(name: "Yuji LLC")
    @merchant_5 = Merchant.create!(name: "Turing LLC")
    visit "/admin/merchants"
  end

  it "shows Admin Dashboard" do
    expect(page).to have_content("Admin Dashboard")
  end

  it "shows name of each merchant" do
    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_content(@merchant_2.name)
    expect(page).to have_content(@merchant_3.name)
    expect(page).to have_content(@merchant_4.name)
    expect(page).to have_content(@merchant_5.name)
  end

  it "each name links to show page" do
    expect(page).to have_link(@merchant_1.name)
    expect(page).to have_link(@merchant_2.name)
    expect(page).to have_link(@merchant_3.name)
    expect(page).to have_link(@merchant_4.name)
    expect(page).to have_link(@merchant_5.name)
    click_on "#{@merchant_1.name}"
    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
    expect(page).to have_content(@merchant_1.name)
    expect(page).to_not have_content(@merchant_2.name)
  end

  it "has button to enable" do
    expect(page).to have_content("Disabled Merchants")
  within "#disabled_merchant-#{@merchant_1.id}" do
      click_on "Enable"
      expect(@merchant_1.reload.status).to eq("enabled")
      expect(current_path).to eq("/admin/merchants")
    end
  end

  it "has button to disable" do
    expect(page).to have_content("Enabled Merchants")
    within "#disabled_merchant-#{@merchant_1.id}" do
      click_on "Enable"
      expect(@merchant_1.reload.status).to eq("enabled")
      expect(current_path).to eq("/admin/merchants")
    end

  within "#enabled_merchant-#{@merchant_1.id}" do
      click_on "Disable"
      expect(@merchant_1.reload.status).to eq("disabled")
      expect(current_path).to eq("/admin/merchants")
    end
  end

  it "link to create new merchant" do
    click_link "New Merchant"
    expect(current_path).to eq("/admin/merchants/new")
  end
end

  describe "admin merchant index page pt2 " do
    let!(:nomi) {Merchant.create!(name: "Naomi LLC")}
    let!(:tyty) {Merchant.create!(name: "TyTy's Grub")}
    let!(:shawn) {Merchant.create!(name: "Shawn LLC")}
    let!(:kristen) {Merchant.create!(name: "Kristen LLC")}
    let!(:yuji) {Merchant.create!(name: "Yuji LLC")}


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

    let!(:shoe) {shawn.items.create!(name: "Shoe", description: "Only the left shoe", unit_price: 800)}
    let!(:belt) {kristen.items.create!(name: "Belt", description: "Only the Leather", unit_price: 800)}
    let!(:sweater) {yuji.items.create!(name: "Sweater", description: "Only the Yarn", unit_price: 800)}

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

    let!(:invoice_item_8) {InvoiceItem.create!(item_id: shoe.id, invoice_id: invoice_1.id, quantity: 10, unit_price: 11, status: "pending")}
    let!(:invoice_item_9) {InvoiceItem.create!(item_id: oil.id, invoice_id: invoice_1.id, quantity: 9, unit_price: 11, status: "pending")}
    let!(:invoice_item_10) {InvoiceItem.create!(item_id: belt.id, invoice_id: invoice_1.id, quantity: 8, unit_price: 11, status: "pending")}
    let!(:invoice_item_11) {InvoiceItem.create!(item_id: sweater.id, invoice_id: invoice_1.id, quantity: 7, unit_price: 11, status: "pending")}

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

    it "has top 5 merchants" do
        visit "/admin/merchants"
        expect(page).to have_content("Top Merchants")
    within "#top_merchant-#{nomi.id}" do
        expect(nomi.name).to appear_before(shawn.name)
        expect(shawn.name).to appear_before(tyty.name)
        expect(tyty.name).to appear_before(kristen.name)
        expect(kristen.name).to appear_before(yuji.name)
      end
    end

    it "expect name to be links and has revnue next to each name" do
      visit "/admin/merchants"
    within "#top_merchant-#{nomi.id}" do
      expect(page).to have_content("Total Revenue: 132")
      click_link(nomi.name)
      expect(current_path).to eq("/admin/merchants/#{nomi.id}")
    end
  end

    it "Date with most revenue for each merchant" do
      visit "/admin/merchants"
      expect(page).to have_content("Top day for #{shawn.name} was #{shawn.merch_best_day}")
    end
end
