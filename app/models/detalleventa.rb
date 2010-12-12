#encoding: utf-8

class Detalleventa < ActiveRecord::Base

  #---Dependencia Existencial---
  belongs_to :producto
  belongs_to :venta

  attr_accessor :nombre_de_producto
  attr_accessor :cantidad_old

  before_validation :find_producto
  #validates_uniqueness_of :producto_id, :message => "ya se encuentra agregado, verifique" #valida que el producto no se repita en los detalles
  validates_presence_of :nombre_de_producto
  validates_numericality_of :cantidad, :greater_than => 0

  validate :valida_cantidad_stock

  after_update :decrementar_stock_update
  after_create :decrementar_stock
  #before_save :decrementar_stock #funciona
  #before_update :decrementar_stock
  #after_destroy :incrementar_stock


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
    producto = Producto.find_by_id(self.producto_id)
    producto.stock_real = producto.stock_real - self.cantidad
    producto.save
  end

  def decrementar_stock_update
    producto = Producto.find_by_id(self.producto_id)
    if self.cantidad_was < self.cantidad
      diferencia = self.cantidad - self.cantidad_was
      producto.stock_real = producto.stock_real - diferencia
    elsif self.cantidad_was > self.cantidad
      #diferencia = self.cantidad_was - self.cantidad
      producto.stock_real += self.cantidad_was
      producto.stock_real = producto.stock_real - self.cantidad
    end
    producto.save
  end

  def incrementar_stock
    producto = Producto.find_by_id(self.producto_id)
    producto.stock_real = producto.stock_real + self.cantidad
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
