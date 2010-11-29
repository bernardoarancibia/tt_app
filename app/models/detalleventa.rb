#encoding: utf-8

class Detalleventa < ActiveRecord::Base

  #---Dependencia Existencial---
  belongs_to :producto
  belongs_to :venta

  attr_accessor :nombre_de_producto

  before_validation :find_producto

  validates_presence_of :nombre_de_producto
  validates_numericality_of :cantidad

  validate :valida_cantidad_stock

  after_save :decrementar_stock
  #after_update :decrementar_stock


  def find_producto
    producto = Producto.find_by_nombre(self.nombre_de_producto)
    if producto.nil?
      errors.add(:nombre_de_producto, "no es válido")
    else
      self.producto = producto
      self.precio_historico = producto.precio_unitario
      calcular_detalleventa self.precio_historico, self.cantidad, producto.granel
    end
  end

  private #-----------

  def calcular_detalleventa precio, cantidad, granel
    if granel
      self.total_detalle = (precio * cantidad) / 1000
    else
      self.total_detalle = precio * cantidad
    end
  end

  def decrementar_stock
    producto = Producto.find_by_nombre(self.nombre_de_producto)
    producto.stock_real = producto.stock_real - self.cantidad
    producto.save
  end

  def valida_cantidad_stock
    if self.producto
      if self.producto.stock_real == 0
        errors.add(self.producto.nombre, "no tiene stock disponible")
      elsif self.cantidad > producto.stock_real
        errors.add(:cantidad, "es mayor que el stock disponible")
      end
    end
  end


end
