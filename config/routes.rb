Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'welcome#index'
  get "/admin", to: 'admin#index'

	resources :merchants, only: [:edit, :update, :new, :create] do
		member do 
			get 'dashboard'
		end
    resources :bulk_discounts, controller: 'merchant_bulk_discounts', only: [:new, :destroy, :show, :index, :create, :edit, :update]
    resources :invoices, controller: 'merchant_invoices', only: [:show, :update]
	end

  resources :invoice_items, only: [:update]

  namespace :admin do
    resources :invoices, only: [:index, :show, :update]
    resources :merchants, only: [:index, :show]
  end

  get "/merchants/:id/items", to: "merchant_items#index"
	get "/merchants/:id/invoices", to: "merchant_invoices#index"

  get "/merchants/:merchant_id/items/new", to: "merchant_items#new"
  post "/merchants/:merchant_id/items", to: "merchant_items#create"
  get "/merchants/:merchant_id/items/:item_id", to: "merchant_items#show"
  get "/merchants/:merchant_id/items/:item_id/edit", to: "merchant_items#edit"
  patch "/merchants/:merchant_id/items/:item_id", to: "merchant_items#update"
end
