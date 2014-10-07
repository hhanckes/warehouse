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
