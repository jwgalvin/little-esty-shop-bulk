Rails.application.routes.draw do
  get '/', to: 'welcome#index'

  get 'admin/invoices/:invoice_id', to: 'admin/invoices#show'

  namespace :merchants, module: :merchants do
    get ':id', to: 'dashboard#index'

    get ':id/items', to: 'items#index'
    get ':id/items/new', to: 'items#new'
    get ':merchant_id/items/:item_id', to: 'items#show'
    get ':merchant_id/items/:item_id/edit', to: 'items#edit'
    patch ':merchant_id/items/:item_id', to: 'items#update'
    post ':id/items', to: 'items#create'

    get ':id/invoices', to: 'invoices#index'
    get ':merchant_id/invoices/:invoice_id', to: 'invoices#show'
    patch ':merchant_id/invoices/:invoice_id', to: 'invoices#update'

    get ':id/discounts', to: 'discounts#index'
    get ':id/discounts/new', to: 'discounts#new'
    post ':id/discounts', to: 'discounts#create'
    get ':id/discounts/:id',  to: 'discounts#show'
    delete ':id/discounts/:id', to: 'discounts#destroy'
    get ':id/discounts/:id/edit', to: 'discounts#edit'
    patch ':id/discounts/:id', to: 'discounts#update'
  end

  namespace :admin, module: :admin do
    get '/', to: 'dashboard#index'
    resources :merchants, only:[:index, :new, :show, :create, :edit, :update]

    resources :invoices, only:[:index, :show, :update]
  end

end
