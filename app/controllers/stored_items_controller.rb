class StoredItemsController < ApplicationController
  before_action :set_stored_item, only: [:show, :edit, :update, :destroy]

  def index
    @stored_items = StoredItem.all
    respond_with(@stored_items)
  end

  def show
    respond_with(@stored_item)
  end

  def new
    @stored_item = StoredItem.new
    respond_with(@stored_item)
  end

  def edit
  end

  def create
    @stored_item = StoredItem.new(stored_item_params)
    @stored_item.save
    respond_with(@stored_item)
  end

  def update
    @stored_item.update(stored_item_params)
    respond_with(@stored_item)
  end

  def destroy
    @stored_item.destroy
    respond_with(@stored_item)
  end

  private
    def set_stored_item
      @stored_item = StoredItem.find(params[:id])
    end

    def stored_item_params
      params.require(:stored_item).permit(:order_storage_item_id, :name, :description, :assigned_value)
    end
end
