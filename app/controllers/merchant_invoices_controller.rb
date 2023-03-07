class MerchantInvoicesController < ApplicationController

  def index
    @merchant = Merchant.find(params[:id])
    @invoices = @merchant.invoices_with_items
  end

  def show
		@invoice = Invoice.find(params[:id])
		@merchant = Merchant.find(params[:merchant_id])
    @invoice_items = @invoice.invoice_items_for_merchant(@merchant.id)
    @total_revenue = @invoice.merchant_total_revenue(@merchant.id)
    @discounted_revenue = @invoice.merchant_discounted_revenue(@merchant.id)
    @invoice_items_with_discounts = @invoice.invoice_items_with_discounts(@merchant.id)
	end

end
