#encoding: utf-8

class Detalleventa < ActiveRecord::Base

  #---Dependencia Existencial---
  belongs_to :producto
  belongs_to :venta

  attr_accessor :nombre_de_producto

  before_validation :find_producto

  validates_presence_of :nombre_de_producto
  validates_numericality_of :cantidad

  # aqui crear el campo virtual producto_nombre


  def find_producto
    producto = Producto.find_by_nombre(self.nombre_de_producto)
    if producto.nil?
      errors.add(:nombre_de_producto, "no es válido")
    else
      self.producto = producto
      self.precio_historico = producto.precio_unitario
      self.total_detalle = self.precio_historico * self.cantidad
    end
  end

end
