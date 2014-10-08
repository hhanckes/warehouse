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
aux << (OrderStatus.find_by_name('Step 1') || OrderStatus.create(:name => 'Step 1'))
aux << (OrderStatus.find_by_name('Step 2') || OrderStatus.create(:name => 'Step 2'))
aux << (OrderStatus.find_by_name('Step 3') || OrderStatus.create(:name => 'Step 3'))
aux.each { |x| puts x.name }
puts "\n"

puts "--> StorageItem:"
aux = []
aux << (StorageItem.find_by_name('Regular Boxes') || StorageItem.create(:name => 'Regular Boxes', price: 4990))
aux << (StorageItem.find_by_name('Bike') || StorageItem.create(:name => 'Bike', price: 14990))
aux << (StorageItem.find_by_name('Golf') || StorageItem.create(:name => 'Golf', price: 9990))
aux << (StorageItem.find_by_name('Ski') || StorageItem.create(:name => 'Ski', price: 9990))
aux << (StorageItem.find_by_name('AC') || StorageItem.create(:name => 'AC', price: 12990))
aux << (StorageItem.find_by_name('Carry On') || StorageItem.create(:name => 'Carry On', price: 4990))
aux << (StorageItem.find_by_name('Luggage') || StorageItem.create(:name => 'Luggage', price: 9990))
aux << (StorageItem.find_by_name('Wardrobe') || StorageItem.create(:name => 'Wardrobe', price: 9990))
aux << (StorageItem.find_by_name('Other') || StorageItem.create(:name => 'Other', price: 9990))
aux.each { |x| puts x.name }
puts "\n"