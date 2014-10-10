# encoding: UTF-8
class StoredItemsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    add_breadcrumb "Menú Principal", user_main_menu_path
    add_breadcrumb "Inventario", stored_items_path
    
    unless params[:q].blank?
      @q = params[:q]
      @stored_items = current_user.stored_items.where('stored_items.name like "%'+@q+'%" or stored_items.description like "%'+@q+'%"').uniq
    else
      @stored_items = current_user.stored_items
    end
  end
  
end
