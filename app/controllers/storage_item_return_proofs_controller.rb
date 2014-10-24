class StorageItemReturnProofsController < ApplicationController
  before_filter :authenticate_user!, :redirect_unless_is_god
  before_action :set_storage_item_return_proof, only: [:show, :edit, :update, :destroy]

  def index
    add_breadcrumb "Administrador", admin_path
    add_breadcrumb "Return Proofs", storage_item_return_proofs_path
    
    @storage_item_return_proofs = StorageItemReturnProof.all
  end

  def show
    add_breadcrumb "Administrador", admin_path
    add_breadcrumb "Return Proofs", storage_item_return_proofs_path
    add_breadcrumb "Return Proof", @storage_item_return_proof
  end

  def new
    @storage_item_return_proof = StorageItemReturnProof.new
  end

  def edit
    add_breadcrumb "Administrador", admin_path
    add_breadcrumb "Return Proofs", storage_item_return_proofs_path
    add_breadcrumb "Return Proof", @storage_item_return_proof
    
  end

  def create
    @new_status = OrderStorageItemStatus.find_by_name('Return in progress') if params[:commit] == 'Fondos Recibidos'
    @new_status = OrderStorageItemStatus.find_by_name('Shipped from Warehouse') if params[:commit] == 'Items Despachados'
    @new_status = OrderStorageItemStatus.find_by_name('Returned') if params[:commit] == 'Guardar'
    @storage_item_return_proof = StorageItemReturnProof.new(storage_item_return_proof_params) if params[:commit] == 'Guardar'
    
    params[:order_storage_item_ids].each do |osi_id|
      osi = OrderStorageItem.find(osi_id)
      osi.order_storage_item_status = @new_status
      osi.save
      (@storage_item_return_proof.order_storage_items << osi) if params[:commit] == 'Guardar'
    end
    @storage_item_return_proof.save if params[:commit] == 'Guardar'

    redirect_to storage_items_waiting_to_be_returned_path, notice: 'Item actualizado correctamente.'
  end

  def update
    respond_to do |format|
      if @storage_item_return_proof.update(storage_item_return_proof_params)
        format.html { redirect_to @storage_item_return_proof, notice: 'Storage Item Return Proof actualizado correctamente.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @storage_item_return_proof.errors, status: :unprocessable_entity }
      end
    end
    
  end

  def destroy
    @return_in_progress = OrderStorageItemStatus.find_by_name('Return in progress')
    @storage_item_return_proof.order_storage_items.each do |osi|
      osi.update_attribute :order_storage_item_status_id, @return_in_progress.id
    end
    @storage_item_return_proof.destroy
    respond_to do |format|
      format.html { redirect_to storage_item_return_proofs_path }
      format.json { head :no_content }
    end
  end

  private
    def set_storage_item_return_proof
      @storage_item_return_proof = StorageItemReturnProof.find(params[:id])
    end

    def storage_item_return_proof_params
      params.require(:storage_item_return_proof).permit(:comments, :photo)
    end
end
