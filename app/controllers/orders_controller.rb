class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :step2, :update, :destroy]

  def index
    add_breadcrumb "Administrador", admin_path
    add_breadcrumb "Orders", orders_path
    
    @orders = Order.all
  end

  def show
    
  end

  def new
    add_breadcrumb "Inicio", admin_path
    add_breadcrumb "Nueva Orden", new_order_path
    
    @order = Order.new
  end

  def edit
  end
  
  def step1
    order_status = OrderStatus.find_by_name('Step 1')
    @order = Order.create(order_status_id: order_status.id)
    
    params[:order_area][:area]
    if is_number?(params[:boxes])
      si = StorageItem.find_by_name('Regular Boxes')
      count = params[:boxes]
      OrderStorageItem.create(order_id: @order.id, storage_item_id: si.id, quantity: count)
    end        
    if is_number?(params['bike-count'])
      si = StorageItem.find_by_name('Bike')
      count = params['bike-count']
      OrderStorageItem.create(order_id: @order.id, storage_item_id: si.id, quantity: count)
    end    
    if is_number?(params['golf-count'])
      si = StorageItem.find_by_name('Golf')
      count = params['golf-count']
      OrderStorageItem.create(order_id: @order.id, storage_item_id: si.id, quantity: count)
    end    
    if is_number?(params['ski-count'])
      si = StorageItem.find_by_name('Ski')
      count = params['ski-count']
      OrderStorageItem.create(order_id: @order.id, storage_item_id: si.id, quantity: count)
    end    
    if is_number?(params['ac-count'])
      si = StorageItem.find_by_name('AC')
      count = params['ac-count']
      OrderStorageItem.create(order_id: @order.id, storage_item_id: si.id, quantity: count)
    end    
    if is_number?(params['carry-on-count'])
      si = StorageItem.find_by_name('Carry On')
      count = params['carry-on-count']
      OrderStorageItem.create(order_id: @order.id, storage_item_id: si.id, quantity: count)
    end    
    if is_number?(params['luggage-count'])
      si = StorageItem.find_by_name('Luggage')
      count = params['lugagge-count']
      OrderStorageItem.create(order_id: @order.id, storage_item_id: si.id, quantity: count)
    end    
    if is_number?(params['wardrobe-count'])
      si = StorageItem.find_by_name('Wardrobe')
      count = params['wardrobe-count']
      OrderStorageItem.create(order_id: @order.id, storage_item_id: si.id, quantity: count)
    end    
    if is_number?(params['other-count'])
      si = StorageItem.find_by_name('Other')
      count = params['other-count']
      OrderStorageItem.create(order_id: @order.id, storage_item_id: si.id, quantity: count)
    end
    redirect_to step2_order_path(@order), notice: 'Order creada correctamente.'
  end
  
  def step2
    
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
