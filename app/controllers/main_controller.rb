# encoding: UTF-8
class MainController < ApplicationController
  before_filter :authenticate_user!, :redirect_unless_is_god, except: [:home, :faqs, :user_main_menu]
  
  def home
  end
  
  def faqs
    @faq_sections = FaqSection.all
  end 
  
  #GET
  def user_main_menu
    add_breadcrumb "Menú Principal", user_main_menu_path
  end
  
  #ADMIN STUFF
  
  def admin
  end
  
  #GET
  def orders
    add_breadcrumb "Administrador", admin_path
    add_breadcrumb "Administrar Ordenes", main_orders_path
    
    step1 = OrderStatus.find_by_name('Step 1')
    step2 = OrderStatus.find_by_name('Step 2')
    @orders = Order.where('order_status_id <> ? and order_status_id <> ?', step1.id, step2.id).order('created_at DESC')

    
    @in_warehouse = OrderStorageItemStatus.find_by_name('In warehouse')
    @return_in_progress = OrderStorageItemStatus.find_by_name('Return in progress')
    @returned = OrderStorageItemStatus.find_by_name('Returned')
    
    @funds_received = OrderStatus.find_by_name('Transfer funds received')
    @delivered = OrderStatus.find_by_name('Delivered')
    @collected = OrderStatus.find_by_name('Collected')
    
    render :template => "orders/index"
  end
  
  #DELETE
  def destroy_order_storage_item
    @order_storage_item = OrderStorageItem.find(params[:id])
    notice = @order_storage_item.storage_item.name+' id # '+@order_storage_item.id.to_s+' eliminado de la orden '+@order_storage_item.order.id.to_s
    @order_storage_item.destroy
    respond_to do |format|
      format.html { redirect_to main_orders_path, notice: notice }
      format.json { head :no_content }
    end    
  end
  
  #POST
  def update_order_storage_item
    @order_storage_item = OrderStorageItem.find(params[:id])
    respond_to do |format|
      if @order_storage_item.update(order_storage_item_params)
        format.html { redirect_to main_orders_path, notice: 'Storage Item actualizado correctamente.' }
      else
        format.html { redirect_to main_orders_path, alert: 'ERROR Storage Item NO actualizado correctamente.' }
      end
    end
  end
  
  private
  
  def order_storage_item_params
    params.require(:order_storage_item).permit(:photo, stored_items_attributes: [:id, :name, :description, :quantity, :assigned_value, :_destroy])
  end
  
end
