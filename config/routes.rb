Rails.application.routes.draw do
  resources :orders do
    post 'step1', on: :collection
    get 'payments', on: :collection
    get 'step2', on: :member
    patch 'step2', on: :member
    get 'step3', on: :member
    post 'transfer_confirmed', on: :member
    post 'update_order_status/:new_order_status_id', on: :member, :action => 'update_order_status', as: 'update_order_status'
    post 'update_order_storage_item_status/:order_storage_item_id/:new_order_storage_item_status_id', on: :member, :action => 'update_order_storage_item_status', as: 'update_order_storage_item_status'
  end
  
  resources :stored_items, only: [:index]
  resources :storage_items
  resources :countries
  resources :addresses
  resources :faq_sections
  resources :faqs
  resources :information_pages
  resources :testimonies
  devise_for :users
  
  get 'user_main_menu' => 'main#user_main_menu', as: 'user_main_menu'
  get 'admin/menu' => 'main#admin', as: 'admin'
  get 'admin/orders' => 'main#orders', as: 'main_orders'
  get 'preguntas-frecuentes' => 'main#faqs', as: 'main_faqs'
  delete 'destroy_order_storage_item/:id' => 'main#destroy_order_storage_item', as: 'destroy_order_storage_item'
  patch 'update_order_storage_item/:id' => 'main#update_order_storage_item', as: 'update_order_storage_item'
  root 'main#home'
end
