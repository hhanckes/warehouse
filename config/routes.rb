Rails.application.routes.draw do
  resources :stored_items

  resources :orders do
    post 'step1', on: :collection
    get 'step2', on: :member
  end

  resources :storage_items

  resources :countries
  resources :addresses
  resources :faq_sections
  resources :faqs
  resources :information_pages
  resources :testimonies
  devise_for :users
  
  get 'admin' => 'main#admin', as: 'admin'
  get 'preguntas-frecuentes' => 'main#faqs', as: 'main_faqs'
  
  root 'main#home'
end
