# encoding: UTF-8
class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :step2, :step3, :transfer_confirmed, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :transfer_confirmed, :destroy]

  def index
    add_breadcrumb "Menú Principal", user_main_menu_path
    add_breadcrumb "Pedidos", orders_path
    
    @h1 = 'Tus Pedidos'
    @orders = current_user.orders
  end

  def show
    
  end

  def new
    @order = Order.new
  end

  def edit
  end
  
  #POST
  def step1
    order_status = OrderStatus.find_by_name('Step 1')
    @order = Order.create(order_status_id: order_status.id)
    osis = OrderStorageItemStatus.find_by_name('Waiting funds confirmation')
    params[:order_area][:area]
    if is_number?(params[:boxes])
      si = StorageItem.find_by_name('Regular Boxes')
      count = params[:boxes].to_i
      (0..count).each do |i|
        OrderStorageItem.create(order_id: @order.id, storage_item_id: si.id, order_storage_item_id: osis.id)
      end
    end        
    if is_number?(params['bike-count'])
      si = StorageItem.find_by_name('Bike')
      count = params['bike-count'].to_i
      (0..count).each do |i|
        OrderStorageItem.create(order_id: @order.id, storage_item_id: si.id, order_storage_item_id: osis.id)
      end
    end    
    if is_number?(params['golf-count'])
      si = StorageItem.find_by_name('Golf')
      count = params['golf-count'].to_i
      (0..count).each do |i|
        OrderStorageItem.create(order_id: @order.id, storage_item_id: si.id, order_storage_item_id: osis.id)
      end
    end    
    if is_number?(params['ski-count'])
      si = StorageItem.find_by_name('Ski')
      count = params['ski-count'].to_i
      (0..count).each do |i|
        OrderStorageItem.create(order_id: @order.id, storage_item_id: si.id, order_storage_item_id: osis.id)
      end
    end    
    if is_number?(params['ac-count'])
      si = StorageItem.find_by_name('AC')
      count = params['ac-count'].to_i
      (0..count).each do |i|
        OrderStorageItem.create(order_id: @order.id, storage_item_id: si.id, order_storage_item_id: osis.id)
      end
    end    
    if is_number?(params['carry-on-count'])
      si = StorageItem.find_by_name('Carry On')
      count = params['carry-on-count'].to_i
      (0..count).each do |i|
        OrderStorageItem.create(order_id: @order.id, storage_item_id: si.id, order_storage_item_id: osis.id)
      end
    end    
    if is_number?(params['luggage-count'])
      si = StorageItem.find_by_name('Luggage')
      count = params['lugagge-count'].to_i
      (0..count).each do |i|
        OrderStorageItem.create(order_id: @order.id, storage_item_id: si.id, order_storage_item_id: osis.id)
      end
    end    
    if is_number?(params['wardrobe-count'])
      si = StorageItem.find_by_name('Wardrobe')
      count = params['wardrobe-count'].to_i
      (0..count).each do |i|
        OrderStorageItem.create(order_id: @order.id, storage_item_id: si.id, order_storage_item_id: osis.id)
      end
    end    
    if is_number?(params['other-count'])
      si = StorageItem.find_by_name('Other')
      count = params['other-count'].to_i
      (0..count).each do |i|
        OrderStorageItem.create(order_id: @order.id, storage_item_id: si.id, order_storage_item_id: osis.id)
      end
    end
    redirect_to step2_order_path(@order)
  end
  
  #GET & POST
  def step2
    if request.patch? 
      if User.find_by_email(params[:email]).blank?
        user = User.new(:email => params[:email], :password => params[:password], :password_confirmation => params[:password])
        user.save
    
        address = Address.create(user_id: user.id, name: params[:name], post_code: params[:post_code], area_id: params[:area_id], receiver: params[:receiver], phone_number: params[:phone_number])
        @order.update_attribute :address_id, address.id
    
        order_status = OrderStatus.find_by_name('Step 2')
        @order.update_attribute :user_id, user.id
        @order.update_attribute :order_status_id, order_status.id
        @order.update_attribute :delivery_date, params['delivery-day']
        @order.update_attribute :delivery_time, params['delivery-time']
        @order.update_attribute :collection_date, params['collection-day']
        @order.update_attribute :collection_time, params['collection-time']
        @order.update_attribute :company_name, params[:company_name]
        @order.update_attribute :company_rut, params[:rut]
        @order.update_attribute :concierge, params[:doorman]
        @order.update_attribute :neighbour, params[:neighbour]
        sign_in user
      
        redirect_to step3_order_path(@order), notice: '¡Estás a un paso de completar el pedido!'
      else
        redirect_to step2_order_path(@order), alert: '¡El usuario ya existe debes ingresar para continuar!'
      end
    end
  end
  
  #GET
  def step3
    
  end
  
  #POST
  def transfer_confirmed
    order_status = OrderStatus.find_by_name('Transfer waiting approval')
    @order.update_attribute :order_status_id, order_status.id
    
    osis = OrderStorageItemStatus.find_by_name('Collection in progress')
    @order.order_storage_items.each do |osi|
      osi.update_attribute :order_storage_item_id, osis.id
    end
    
    redirect_to root_path, notice: '¡Todo OK! Procederemos a validar tu transferencia dentro de las próximas horas.'
  end
  
  def create
    @order = Order.new(order_params)
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order creada correctamente.' }
        format.json { render action: 'show', status: :created, location: @order }
      else
        format.html { render action: 'new' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order actualizado correctamente.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_path }
      format.json { head :no_content }
    end
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:user_id, :address_id, :order_status_id)
    end
end
