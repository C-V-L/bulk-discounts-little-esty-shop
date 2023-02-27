require 'rails_helper'

RSpec.describe 'Merchant Invoices Index' do
  before (:each) do
		Merchant.destroy_all
		Customer.destroy_all
		Invoice.destroy_all
		Item.destroy_all
		Transaction.destroy_all
		InvoiceItem.destroy_all
		@merchant = Merchant.create!(name: "Carlos Jenkins") 
		@cust1 = Customer.create!(first_name: "Laura", last_name: "Fiel")
		@cust2 = Customer.create!(first_name: "Bob", last_name: "Fiel")
		
		@inv1 = @cust1.invoices.create!(status: 1, created_at: "2023-02-26 09:54:09")
		@inv2 = @cust1.invoices.create!(status: 1)
		
		@bowl = @merchant.items.create!(name: "bowl", description: "it's a bowl", unit_price: 350) 
		@knife = @merchant.items.create!(name: "knife", description: "it's a knife", unit_price: 250) 
		@plate = @merchant.items.create!(name: "plate", description: "it's a plate", unit_price: 250) 
		
		@trans1 = @inv1.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
		
		InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv1.id)
		InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv1.id)
		InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv1.id)
		InvoiceItem.create!(item_id: @knife.id, invoice_id: @inv1.id)
		InvoiceItem.create!(item_id: @knife.id, invoice_id: @inv1.id)
		InvoiceItem.create!(item_id: @plate.id, invoice_id: @inv1.id)
	end

	describe 'As a merchant, when I visit my merchant invoices show page' do
		it 'Then I see information related to that invoice' do
			visit "/merchants/#{@merchant.id}/invoices/#{@inv1.id}"
			
			expect(page).to have_content("Invoice ID: #{@inv1.id}")
			expect(page).to_not have_content("Invoice ID: #{@inv2.id}")
			expect(page).to have_content("Invoice Status: #{@inv1.status}")
			expect(page).to have_content("Invoice Created at: Sunday, February 26, 2023")
			expect(page).to have_content("Customer: Laura Fiel")
			expect(page).to_not have_content("Customer: Bob Fiel")
		end
	end
end