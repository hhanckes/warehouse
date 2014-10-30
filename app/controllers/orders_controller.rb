# encoding: UTF-8
class OrdersController < ApplicationController
  before_action :set_order, only: [:add_osi_to_return_list, :show, :edit, :step2, :step3, :transfer_confirmed, :update, :destroy, :update_order_status, :update_order_storage_item_status, :transfer_confirmed_return_osi, :order_success]
  before_action :set_order_storage_item, only: [:update_order_storage_item_status, :add_osi_to_return_list]
  before_action :authenticate_user!, except: [:new, :step1, :step2, :step3]

  def index
    add_breadcrumb "Menú Principal", user_main_menu_path
    add_breadcrumb "Pedidos", orders_path
    
    @h1 = 'Tus Pedidos'
    step1 = OrderStatus.find_by_name('Step 1')
    step2 = OrderStatus.find_by_name('Step 2')

    @in_warehouse = OrderStorageItemStatus.find_by_name('In warehouse')
    @return_in_progress = OrderStorageItemStatus.find_by_name('Return in progress')
    @returned = OrderStorageItemStatus.find_by_name('Returned')
    
    @regular_boxes = StorageItem.find_by_name('Regular Boxes')

    @orders = current_user.orders.where('order_status_id <> ? and order_status_id <> ?', step1.id, step2.id).order 'created_at DESC'
  end

  def show
    add_breadcrumb "Menú Principal", user_main_menu_path
    add_breadcrumb "Pedidos", orders_path
    add_breadcrumb "Pedido #"+@order.id.to_s, @order
    
    @in_warehouse = OrderStorageItemStatus.find_by_name('In warehouse')
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
    status = PaymentStatus.find_by_name('Transfer waiting approval')
    type = PaymentType.find_by_name('Monthly payment')
    payment = Payment.create(amount: current_user.in_warehouse_order_storage_items.sum(:price), payment_status_id: status.id, payment_type_id: type.id)
    
    params[:payment_month].each do |month_year|
      aux = month_year.split('-')
      payment.payment_months << (PaymentMonth.find_by_month_and_year(aux[0], aux[1]) || PaymentMonth.create(:month => aux[0], :year => aux[1]))
    end
    
    current_user.in_warehouse_order_storage_items.each do |osi|
      payment.order_storage_items << osi
    end
    payment.save
    payment.notify
    redirect_to payments_orders_path, notice: 'Pago creado exitosamente. Pronto validaremos la recepción de fondos y te llegará un correo confirmando.'
  end
  
  def edit
  end
  
  #POST
  def step1
    if params[:order_area][:area].blank?
      redirect_to new_order_path, alert: 'Debes seleccionar el sector donde entregaremos las cajas'
    else
      order_status = OrderStatus.find_by_name('Step 1')
      @order = Order.create(order_status_id: order_status.id)
      if !update_step1_order_attributes
        redirect_to(new_order_path, alert: 'Debes seleccionar el al menos un item para continuar con el proceso') 
      else
        redirect_to step2_order_path(id: @order.id, area: params[:order_area][:area])
      end
    end
  end
  
  #GET & POST
  def step2
    step1 = OrderStatus.find_by_name('Step 1')
    unless @order.order_status_id != step1.id and params[:address_changed].blank? and !request.patch?
      @boxes_in_order = @order.storage_items.include?(StorageItem.find_by_name('Regular Boxes'))
  		@address = current_user.default_address if user_signed_in?
  		@area = Area.find params[:area]
      if request.patch? 
        if @address.blank? and (params[:area].blank? or params[:name].blank? or params[:receiver].blank? or params[:phone_number].blank?)
          flash[:alert] = "Debes ingresar la información completa para poder ir a dejarte las cajas y recoger los items!"
          render :template => "orders/step2"
        elsif !params[:company].blank? and (params[:company_name].blank? or params[:rut].blank?)
          flash[:alert] = "Debes agregar los datos de la empresa (RUT y Nombre)!"
          render :template => "orders/step2"
        elsif params['collect_later'].blank? and params['collect_immediately'].blank? and @boxes_in_order
          flash[:alert] = "Debes seleccionar cuando vamos a buscar las cajas!"
          render :template => "orders/step2"
        else
          if User.find_by_email(params[:email]).blank?
            update_step2_order_attributes
            redirect_to step3_order_path(@order), notice: '¡Estás a un paso de completar el pedido!'
          else
            flash[:alert] = "El usuario ya existe. Debes ingresar con tu cuenta y usuario para continuar."
            render :template => "orders/step2"
          end
        end
      end
    else
      redirect_to root_path, alert: 'El pedido ya pasó por esta etapa. Comienza uno nuevo.'
    end
  end
  
  #GET
  def step3
    
  end
  
  def order_success
  end
  
  def order_return_success  
    @order_return = OrderReturn.find params[:order_return_id]
  end
  
  #POST
  def transfer_confirmed
    order_status = OrderStatus.find_by_name('Transfer waiting approval')
    @order.update_attribute :order_status_id, order_status.id
    
    redirect_to order_success_order_path(@order), notice: '¡Todo OK! Procederemos a validar tu pago dentro de las próximas horas. En esta página encontrarás el detalle de tu orden'
  end
  
  #POST CALLED VIA AJAX
  def add_osi_to_return_list
    user = @order.user
    order_return_status = OrderReturnStatus.find_by_name('Adding items')
    
    order_return = user.order_returns.where('order_return_status_id = ?', order_return_status.id).first.blank? ? OrderReturn.create(order_return_status_id: order_return_status.id, user_id: user.id) : user.order_returns.where('order_return_status_id = ?', order_return_status.id).first
    if @order_storage_item.order_return.blank?
      @order_storage_item.update_attribute :order_return_id, order_return.id
    else
      @order_storage_item.update_attribute :order_return_id, nil
    end
    
    respond_to do |format|
      format.json  { render :json => { return_requested: !@order_storage_item.order_return.blank?, items_requested: order_return.order_storage_items.size } }
    end
  end
  
  #GET
  def return_items
    order_return_status = OrderReturnStatus.find_by_name('Adding items')
    @order_return = current_user.order_returns.where('order_return_status_id = ?', order_return_status.id).first
  end
  
  #POST
  def transfer_confirmed_return_order
    order_return = OrderReturn.find params[:order_return_id]
    order_return_status = OrderReturnStatus.find_by_name('Return requested')
    funds_return = OrderStorageItemStatus.find_by_name('Wating funds confirmation for return')
    
    order_return.return_delivery_day = params['delivery-day']
    order_return.return_delivery_time = params['delivery-time']
    order_return.address_id = params[:address_id]
    order_return.order_return_status = order_return_status
          
    order_return.order_storage_items.each do |osi|
      osi.update_attribute :order_storage_item_status_id, funds_return.id
    end
    order_return.save
    order_return.notify
    redirect_to order_return_success_orders_path(order_return_id: order_return.id)
  end
  
  #POST
  def update_order_status
    order_status = OrderStatus.find params[:new_order_status_id]
    @order.order_status = order_status
    @order.save
    if current_user.is_god?
      redirect_to main_order_details_path(@order), notice: 'Estado de la orden #'+@order.id.to_s+' actualizado correctamente'
    else
      redirect_to @order, notice: 'Estado de la orden #'+@order.id.to_s+' actualizado correctamente'
    end
  end

  #POST
  def update_order_storage_item_status
    status = OrderStorageItemStatus.find params[:new_order_storage_item_status_id]
    @order_storage_item.order_storage_item_status = status
    @order_storage_item.save
    if current_user.is_god?
      redirect_to main_order_details_path(@order_storage_item.order), notice: 'Estado de la orden #'+@order.id.to_s+' actualizado correctamente'
    else
      redirect_to @order_storage_item.order, notice: 'Estado de la orden #'+@order.id.to_s+' actualizado correctamente'
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

    def update_step1_order_attributes
      items_selected = false
      osis = OrderStorageItemStatus.find_by_name('Waiting funds confirmation')
      
      param_names = ['boxes', 'bike-count', 'golf-count', 'ski-count', 'ac-count', 'carry-on-count', 'luggage-count', 'wardrobe-count', 'other-count']
      storage_item_names = ['Regular Boxes', 'Bike', 'Golf', 'Ski', 'AC', 'Carry On', 'Luggage', 'Wardrobe', 'Other']
      
      param_names.each_with_index do |param_name, i|
        if is_number?(params[param_name])
          si = StorageItem.find_by_name(storage_item_names[i])
          other_details = params[:other_details].blank? ? 'No aplica' : params[:other_details]
          count = params[param_name].to_i
          (1..count).each do |i|
            OrderStorageItem.create(order_id: @order.id, storage_item_id: si.id, order_storage_item_status_id: osis.id, price: si.price, return_price: si.return_price, details: other_details)
            items_selected = true
          end
        end
      end
      return items_selected
    end

    def update_step2_order_attributes
      order_status = OrderStatus.find_by_name('Step 2')
      unless user_signed_in?
        user = User.new(:email => params[:email], :password => params[:password], :password_confirmation => params[:password], :name => params[:username])
        user.save
        sign_in user
      else
        user = current_user
      end
      if params[:address_id].blank?
        address = Address.create(default: true, area_id: params[:area], user_id: user.id, name: params[:name], post_code: params[:post_code], receiver: params[:receiver], phone_number: params[:phone_number])
      else
        address = Address.find params[:address_id]
      end
      @order.update_attributes(address_id: address.id, user_id: user.id, collect_immediately: params[:collect_immediately], order_status_id: order_status.id, delivery_date: params['delivery-day'], 
        delivery_time: params['delivery-time'], collection_date: params['collection-day'], collection_time: params['collection-time'], company_name: params[:company_name], 
        company_rut: params[:rut], concierge: params[:doorman], neighbour: params[:neighbour])
    end
      
end
