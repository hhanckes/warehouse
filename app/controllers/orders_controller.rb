# encoding: UTF-8
class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :step2, :step3, :transfer_confirmed, :update, :destroy, :update_order_status, :update_order_storage_item_status]
  before_action :set_order_storage_item, only: [:update_order_storage_item_status]
  before_action :authenticate_user!, only: [:index, :transfer_confirmed, :update_order_status, :update_order_storage_item_status, :destroy, :payments]

  def index
    add_breadcrumb "Menú Principal", user_main_menu_path
    add_breadcrumb "Pedidos", orders_path
    
    @h1 = 'Tus Pedidos'
    step1 = OrderStatus.find_by_name('Step 1')
    step2 = OrderStatus.find_by_name('Step 2')
    
    @orders = current_user.orders.where('order_status_id <> ? and order_status_id <> ?', step1.id, step2.id).order 'created_at DESC'
    @return_in_progress = OrderStorageItemStatus.find_by_name('Return in progress')
  end

  def show
    add_breadcrumb "Menú Principal", user_main_menu_path
    add_breadcrumb "Pedidos", orders_path
    add_breadcrumb "Pedido #"+@order.id.to_s, @order
    
    @return_in_progress = OrderStorageItemStatus.find_by_name('Return in progress')
  end

  def new
    @order = Order.new
  end

  def payments
    add_breadcrumb "Menú Principal", user_main_menu_path
    add_breadcrumb "Pagos", payments_orders_path
    
    @done_payments = current_user.payments.order('created_at DESC').uniq
  end
  
  #POST
  def new_payment_paid
    
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
        OrderStorageItem.create(order_id: @order.id, storage_item_id: si.id, order_storage_item_status_id: osis.id)
      end
    end        
    if is_number?(params['bike-count'])
      si = StorageItem.find_by_name('Bike')
      count = params['bike-count'].to_i
      (0..count).each do |i|
        OrderStorageItem.create(order_id: @order.id, storage_item_id: si.id, order_storage_item_status_id: osis.id)
      end
    end    
    if is_number?(params['golf-count'])
      si = StorageItem.find_by_name('Golf')
      count = params['golf-count'].to_i
      (0..count).each do |i|
        OrderStorageItem.create(order_id: @order.id, storage_item_id: si.id, order_storage_item_status_id: osis.id)
      end
    end    
    if is_number?(params['ski-count'])
      si = StorageItem.find_by_name('Ski')
      count = params['ski-count'].to_i
      (0..count).each do |i|
        OrderStorageItem.create(order_id: @order.id, storage_item_id: si.id, order_storage_item_status_id: osis.id)
      end
    end    
    if is_number?(params['ac-count'])
      si = StorageItem.find_by_name('AC')
      count = params['ac-count'].to_i
      (0..count).each do |i|
        OrderStorageItem.create(order_id: @order.id, storage_item_id: si.id, order_storage_item_status_id: osis.id)
      end
    end    
    if is_number?(params['carry-on-count'])
      si = StorageItem.find_by_name('Carry On')
      count = params['carry-on-count'].to_i
      (0..count).each do |i|
        OrderStorageItem.create(order_id: @order.id, storage_item_id: si.id, order_storage_item_status_id: osis.id)
      end
    end    
    if is_number?(params['luggage-count'])
      si = StorageItem.find_by_name('Luggage')
      count = params['lugagge-count'].to_i
      (0..count).each do |i|
        OrderStorageItem.create(order_id: @order.id, storage_item_id: si.id, order_storage_item_status_id: osis.id)
      end
    end    
    if is_number?(params['wardrobe-count'])
      si = StorageItem.find_by_name('Wardrobe')
      count = params['wardrobe-count'].to_i
      (0..count).each do |i|
        OrderStorageItem.create(order_id: @order.id, storage_item_id: si.id, order_storage_item_status_id: osis.id)
      end
    end    
    if is_number?(params['other-count'])
      si = StorageItem.find_by_name('Other')
      count = params['other-count'].to_i
      (0..count).each do |i|
        OrderStorageItem.create(order_id: @order.id, storage_item_id: si.id, order_storage_item_status_id: osis.id)
      end
    end
    redirect_to step2_order_path(@order)
  end
  
  #GET & POST
  def step2
		@address = current_user.default_address if user_signed_in?
    if request.patch? 
      if User.find_by_email(params[:email]).blank?
        unless user_signed_in?
          user = User.new(:email => params[:email], :password => params[:password], :password_confirmation => params[:password])
          user.save
          sign_in user
        else
          user = current_user
        end
        if params[:address_id].blank?
          address = Address.create(default: true, user_id: user.id, name: params[:name], post_code: params[:post_code], area_id: params[:area_id], receiver: params[:receiver], phone_number: params[:phone_number])
        else
          address = Address.find params[:address_id]
        end
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
    
    payment_status = PaymentStatus.find_by_name('Transfer waiting approval')
    payment_type = PaymentType.find_by_name('Monthly payment')
    
    payment = Payment.create(:payment_status_id => payment_status.id, amount: @order.order_storage_items.joins(:storage_item).sum('price'), payment_type_id: payment_type.id)

    payment_month = (PaymentMonth.find_by_month_and_year(DateTime.now.strftime('%m'), DateTime.now.strftime('%Y')) || PaymentMonth.create(:month => DateTime.now.strftime('%m'), :year => DateTime.now.strftime('%Y')))
    payment.payment_months << payment_month
    
    osis = OrderStorageItemStatus.find_by_name('Collection in progress')
    @order.order_storage_items.each do |osi|
      osi.update_attribute :order_storage_item_status_id, osis.id
      payment.order_storage_items << osi
    end
    
    redirect_to root_path, notice: '¡Todo OK! Procederemos a validar tu transferencia dentro de las próximas horas.'
  end
  
  #POST
  def update_order_status
    order_status = OrderStatus.find params[:new_order_status_id]
    @order.order_status = order_status
    @order.save
    if current_user.is_god?
      redirect_to main_orders_path, notice: 'Estado de la orden #'+@order.id.to_s+' actualizado correctamente'
    else
      redirect_to orders_path, notice: 'Estado de la orden #'+@order.id.to_s+' actualizado correctamente'
    end
  end

  #POST
  def update_order_storage_item_status
    status = OrderStorageItemStatus.find params[:new_order_storage_item_status_id]
    @order_storage_item.order_storage_item_status = status
    @order_storage_item.save
    if current_user.is_god?
      redirect_to main_orders_path, notice: 'Estado de la orden #'+@order.id.to_s+' actualizado correctamente'
    else
      redirect_to orders_path, notice: 'Estado de la orden #'+@order.id.to_s+' actualizado correctamente'
    end
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
    def set_order_storage_item
      @order_storage_item = OrderStorageItem.find(params[:order_storage_item_id])
    end
    
    def order_params
      params.require(:order).permit(:user_id, :address_id, :order_status_id)
    end
end
