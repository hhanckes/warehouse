Rails.application.routes.draw do
  resources :contacts, only: [:index, :show, :new, :create]
  resources :blog_posts
  get 'blog' => 'blog_posts#blog', as: 'blog'
  
  resources :storage_item_return_proofs

  resources :orders do
    post 'step1', on: :collection
    get 'payments', on: :collection
    get 'return_items', on: :collection
    post 'transfer_confirmed_return_order/:order_return_id', on: :collection, :action => 'transfer_confirmed_return_order', as: 'transfer_confirmed_return_order'
    get 'order_return_success/:order_return_id', on: :collection, :action => 'order_return_success', as: 'order_return_success'
    get 'step2/:area', on: :member, :action => 'step2', as: 'step2'
    patch 'step2/:area', on: :member, :action => 'step2'
    get 'step3', on: :member
    get 'order_success', on: :member
    get 'order_return_success', on: :member
    post 'add_osi_to_return_list/:osi_id', on: :member, :action => 'add_osi_to_return_list'
    post 'transfer_confirmed', on: :member
    post 'transfer_confirmed_return_osi/:osi_id', on: :member, :action => 'transfer_confirmed_return_osi', as: 'transfer_confirmed_return_osi'
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
  get 'admin/storage_items_waiting_to_be_returned' => 'main#storage_items_waiting_to_be_returned', as: 'storage_items_waiting_to_be_returned'
  
  devise_for :users
  root 'main#home'
end
