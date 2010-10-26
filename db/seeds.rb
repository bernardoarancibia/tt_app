# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Proveedor.create([{
  :nombre => 'CCU',
  :cod_fono => 32,
  :num_fono => 2123123,
  :email => 'ventas@ccu.cl',
  :nombre_encargado => 'José',
  :apellidos_encargado => 'Gómez Araya'
}])
