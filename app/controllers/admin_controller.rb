class AdminController < ApplicationController
  def index
    @top_five_customers = Customer.top_five_customers
  end
end