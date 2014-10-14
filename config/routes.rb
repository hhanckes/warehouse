Rails.application.routes.draw do
  resources :orders do
    post 'step1', on: :collection
    get 'payments', on: :collection
    get 'step2/:area', on: :member, :action => 'step2', as: 'step2'
    patch 'step2/:area', on: :member, :action => 'step2'
    get 'step3', on: :member
    post 'transfer_confirmed', on: :member
    post 'new_payment_paid', on: :collection
    post 'update_order_status/:new_order_status_id', on: :member, :action => 'update_order_status', as: 'update_order_status'
    post 'update_order_storage_item_status/:order_storage_item_id/:new_order_storage_item_status_id', on: :member, :action => 'update_order_storage_item_status', as: 'update_order_storage_item_status'
  end
  
  resources :stored_items, only: [:index]
  resources :storage_items
  resources :countries
  resources :addresses do
    get 'select', on: :member
  end
  resources :faq_sections
  resources :faqs
  resources :information_pages
  resources :testimonies
  resources :subscribers, only: [:index, :create, :edit, :update, :destroy]


  get 'user_main_menu' => 'main#user_main_menu', as: 'user_main_menu'
  get 'admin/menu' => 'main#admin', as: 'admin'
  get 'admin/orders' => 'main#orders', as: 'main_orders'
  get 'admin/payments' => 'main#payments', as: 'main_payments'
  put 'admin/update_payment_status/:payment_id/:status_id' => 'main#update_payment_status', as: 'update_payment_status'
  get 'admin/order_details/:id' => 'main#order_details', as: 'main_order_details'
  get 'preguntas-frecuentes' => 'main#faqs', as: 'main_faqs'
  delete 'destroy_order_storage_item/:id' => 'main#destroy_order_storage_item', as: 'destroy_order_storage_item'
  patch 'update_order_storage_item/:id' => 'main#update_order_storage_item', as: 'update_order_storage_item'
  post 'admin/change_price' => 'main#change_price', as: 'main_change_price'

  devise_for :users
  root 'main#home'
end
