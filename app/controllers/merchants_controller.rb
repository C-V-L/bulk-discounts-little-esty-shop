class MerchantsController < ApplicationController
	
  def dashboard
    @merchant = Merchant.find(params[:id])
    @top_five_customers = @merchant.customers.top_five_customers
    @items_to_ship = @merchant.invoice_items.unshipped_items
    @discounts = @merchant.bulk_discounts
  end

  def new
    @merchant = Merchant.new
  end

  def create
    @merchant = Merchant.new(merchant_params)
    if @merchant.save
      redirect_to admin_merchants_path
    else
      flash[:notice] = "Merchant not created: Name can't be blank"
      redirect_to new_merchant_path
    end

  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    if params[:merchant][:status] == "Enable"
      @merchant.update(status: 1)
      redirect_to "/admin/merchants"
    elsif params[:merchant][:status] == "Disable"
      @merchant.update(status: 0)
      redirect_to "/admin/merchants"
    else
      if @merchant.update(merchant_params)
        @merchant.update(merchant_params)
        flash[:success] = "Merchant was successfully updated."
        redirect_to admin_merchant_path(@merchant)
      else
        flash[:notice] = "Merchant not updated: Name can't be blank"
        redirect_to edit_merchant_path(@merchant)
      end

    end
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name, :status)
  end
end