# encoding: UTF-8
class AddressesController < ApplicationController
  before_action :authenticate_user!
  
  before_action :set_address, only: [:show, :edit, :update, :destroy, :select]

  def index
    add_breadcrumb "Menú Principal", user_main_menu_path
    add_breadcrumb "Direcciones", addresses_path
    
    @addresses = current_user.addresses
    @address = Address.new
    if params[:step] == 2.to_s
      @in_purchase = true
    end
  end
  
  def select
    Address.where('addresses.default = 1 and addresses.id <> ?', @address.id).each do |ad|
      ad.update_attribute :default, false
    end
    @address.update_attribute :default, true
    redirect_to step2_order_path(current_user.orders.last, area: @address.area.id, address_changed: 1)
  end

  def show
  end

  def new
    @address = Address.new
  end

  def edit
  end

  def create
    @address = Address.new(address_params)

    if params[:step] == 2.to_s
      path = addresses_path(step: 2)
    else
      path = addresses_path
    end
    respond_to do |format|
      if @address.save
        format.html { redirect_to path, notice: 'Dirección creada correctamente.' }
        format.json { render action: 'show', status: :created, location: @address }
      else
        format.html { render action: 'new' }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to addresses_path, notice: 'Dirección actualizado correctamente.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @address.destroy
    respond_to do |format|
      format.html { redirect_to addresses_path }
      format.json { head :no_content }
    end
  end

  private
    def set_address
      @address = Address.find(params[:id])
    end

    def address_params
      params.require(:address).permit(:receiver, :name, :post_code, :area_id, :user_id, :phone_number)
    end
end
