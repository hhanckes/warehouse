# encoding: UTF-8
class StoredItemsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    add_breadcrumb "Menú Principal", user_main_menu_path
    add_breadcrumb "Inventario", stored_items_path
    
    @in_warehouse = OrderStorageItemStatus.find_by_name('In warehouse')
    @waiting_funds = OrderStorageItemStatus.find_by_name('Wating funds confirmation for return')
    @return_in_progress = OrderStorageItemStatus.find_by_name('Return in progress')
    
    
    unless params[:q].blank?
      @q = params[:q]
      @stored_items = current_user.stored_items.joins(:order_storage_item).where('order_storage_items.order_storage_item_status_id in (?)', [@in_warehouse.id, @return_in_progress.id, @waiting_funds.id]).where('stored_items.order_storage_item_id = "'+@q+'" or stored_items.name like "%'+@q+'%" or stored_items.description like "%'+@q+'%" or order_storage_items.name like "%'+@q+'%"').uniq
      @in_box = true if is_number? @q
    else
      @stored_items = current_user.stored_items.joins(:order_storage_item).where('order_storage_items.order_storage_item_status_id in (?)', [@in_warehouse.id, @return_in_progress.id, @waiting_funds.id])
    end
  end
  
end
