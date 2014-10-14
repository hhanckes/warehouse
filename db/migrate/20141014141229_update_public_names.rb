# encoding: UTF-8
class UpdatePublicNames < ActiveRecord::Migration
  def change
    OrderStatus.find_by_name('Step 1').update_attribute :public_name, 'Paso 1'
    OrderStatus.find_by_name('Step 2').update_attribute :public_name, 'Paso 2'
    OrderStatus.find_by_name('Transfer waiting approval').update_attribute :public_name, 'Esperando confirmación de pago'
    OrderStatus.find_by_name('Transfer funds received').update_attribute :public_name, 'Pago confirmado'
    OrderStatus.find_by_name('Delivered').update_attribute :public_name, 'Cajas entregadas al cliente'
    OrderStatus.find_by_name('Collected').update_attribute :public_name, 'Recolectado para llevar a la bodega'
    
    StorageItem.find_by_name('Regular Boxes').update_attribute :public_name, 'Caja'
    StorageItem.find_by_name('Bike').update_attribute :public_name, 'Bicicleta'
    StorageItem.find_by_name('Golf').update_attribute :public_name, 'Palos de Golf'
    StorageItem.find_by_name('Ski').update_attribute :public_name, 'Ski'
    StorageItem.find_by_name('AC').update_attribute :public_name, 'Aire Acondicionado'
    StorageItem.find_by_name('Carry On').update_attribute :public_name, 'Maleta de mano'
    StorageItem.find_by_name('Luggage').update_attribute :public_name, 'Maleta'
    StorageItem.find_by_name('Wardrobe').update_attribute :public_name, 'Ropa'
    StorageItem.find_by_name('Other').update_attribute :public_name, 'Otros'
  end
end
