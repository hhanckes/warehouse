class StorageItemsController < ApplicationController
  before_action :set_storage_item, only: [:show, :edit, :update, :destroy]

  def index
    add_breadcrumb "Administrador", admin_path
    add_breadcrumb "Storage Items", storage_items_path
    
    @storage_items = StorageItem.all
  end

  def show
    add_breadcrumb "Administrador", admin_path
    add_breadcrumb "Storage Items", storage_items_path
    add_breadcrumb @storage_item.name, @storage_item
  end

  def new
    @storage_item = StorageItem.new
  end

  def edit
  end

  def create
    @storage_item = StorageItem.new(storage_item_params)
    respond_to do |format|
      if @storage_item.save
        format.html { redirect_to @storage_item, notice: 'Storage Item creada correctamente.' }
        format.json { render action: 'show', status: :created, location: @storage_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @storage_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @storage_item.update(storage_item_params)
        format.html { redirect_to @storage_item, notice: 'Storage Item actualizado correctamente.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @storage_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @storage_item.destroy
    respond_to do |format|
      format.html { redirect_to storage_items_path }
      format.json { head :no_content }
    end
  end

  private
    def set_storage_item
      @storage_item = StorageItem.friendly.find(params[:id])
    end

    def storage_item_params
      params.require(:storage_item).permit(:name, :description, :price, :width, :height, :depth, :dimensions_measure, :capacity, :capacity_measure, :photo)
    end
end
