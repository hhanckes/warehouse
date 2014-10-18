# encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "--> InformationPage:"
aux = []
aux << (InformationPage.find_by_title('Términos y Condiciones') || InformationPage.create(:title => 'Términos y Condiciones'))
aux << (InformationPage.find_by_title('Reglas de Almacenaje') || InformationPage.create(:title => 'Reglas de Almacenaje'))
aux << (InformationPage.find_by_title('Términos Legales y Privacidad') || InformationPage.create(:title => 'Términos Legales y Privacidad'))
aux.each { |x| puts x.title }
puts "\n"

puts "--> OrderStatuses:"
aux = []
aux << (OrderStatus.find_by_name('Step 1') || OrderStatus.create(:name => 'Step 1', public_name: 'Paso 1'))
aux << (OrderStatus.find_by_name('Step 2') || OrderStatus.create(:name => 'Step 2', public_name: 'Paso 2'))
aux << (OrderStatus.find_by_name('Transfer waiting approval') || OrderStatus.create(:name => 'Transfer waiting approval', public_name: 'Esperando confirmación de pago'))
aux << (OrderStatus.find_by_name('Transfer funds received') || OrderStatus.create(:name => 'Transfer funds received', public_name: 'Pago confirmado'))
aux << (OrderStatus.find_by_name('Delivered') || OrderStatus.create(:name => 'Delivered', public_name: 'Cajas entregadas al cliente'))
aux << (OrderStatus.find_by_name('Collected') || OrderStatus.create(:name => 'Collected', public_name: 'Recolectado para llevar a la bodega'))
aux.each { |x| puts x.name }
puts "\n"

puts "--> PaymentStatus:"
aux = []
aux << (PaymentStatus.find_by_name('Transfer waiting approval') || PaymentStatus.create(:name => 'Transfer waiting approval', :public_name => 'Transferencia esperando confirmación'))
aux << (PaymentStatus.find_by_name('Transfer funds received') || PaymentStatus.create(:name => 'Transfer funds received', :public_name => 'Transferencia recibida OK'))
aux.each { |x| puts x.name }
puts "\n"

puts "--> PaymentType:"
aux = []
aux << (PaymentType.find_by_name('Monthly payment') || PaymentType.create(:name => 'Monthly payment', :public_name => 'Mensualidad'))
aux.each { |x| puts x.name }
puts "\n"

puts "--> OrderStorageItemStatuses:"
aux = []
aux << (OrderStorageItemStatus.find_by_name('Waiting funds confirmation') || OrderStorageItemStatus.create(:name => 'Waiting funds confirmation', :public_name => 'Esperando confirmación'))
aux << (OrderStorageItemStatus.find_by_name('Collection in progress') || OrderStorageItemStatus.create(:name => 'Collection in progress', :public_name => 'En proceso de recolección'))
aux << (OrderStorageItemStatus.find_by_name('In warehouse') || OrderStorageItemStatus.create(:name => 'In warehouse', :public_name => 'En bodega'))
aux << (OrderStorageItemStatus.find_by_name('Return in progress') || OrderStorageItemStatus.create(:name => 'Return in progress', :public_name => 'En proceso de devolución'))
aux << (OrderStorageItemStatus.find_by_name('Returned') || OrderStorageItemStatus.create(:name => 'Returned', :public_name => 'Devuelta'))
aux.each { |x| puts x.name }
puts "\n"

puts "--> StorageItem:"
aux = []
aux << (StorageItem.find_by_name('Regular Boxes') || StorageItem.create(:name => 'Regular Boxes', price: 4990, public_name: 'Caja'))
aux << (StorageItem.find_by_name('Bike') || StorageItem.create(:name => 'Bike', price: 14990, public_name: 'Bicicleta'))
aux << (StorageItem.find_by_name('Golf') || StorageItem.create(:name => 'Golf', price: 9990, public_name: 'Palos de Golf'))
aux << (StorageItem.find_by_name('Ski') || StorageItem.create(:name => 'Ski', price: 9990, public_name: 'Ski'))
aux << (StorageItem.find_by_name('AC') || StorageItem.create(:name => 'AC', price: 12990, public_name: 'Aire Acondicionado'))
aux << (StorageItem.find_by_name('Carry On') || StorageItem.create(:name => 'Carry On', price: 4990, public_name: 'Maleta de mano'))
aux << (StorageItem.find_by_name('Luggage') || StorageItem.create(:name => 'Luggage', price: 9990, public_name: 'Maleta'))
aux << (StorageItem.find_by_name('Wardrobe') || StorageItem.create(:name => 'Wardrobe', price: 9990, public_name: 'Ropa'))
aux << (StorageItem.find_by_name('Other') || StorageItem.create(:name => 'Other', price: 0, public_name: 'Otros'))
aux.each { |x| puts x.name }
puts "\n"