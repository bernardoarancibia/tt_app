#encoding:utf-8
class Merma < ActiveRecord::Base

  #---Dependencia Existencial---
  belongs_to :producto

  #---Crear campo nombre_de_producto---
  attr_accessor :nombre_de_producto

  #---Atributos Accesibles---
  #attr_accessible :producto_id, :cantidad, :tipo_merma, :comentario, :nombre_de_producto

  #---Validaciones---

  validates_presence_of :nombre_de_producto

  validate :validar_producto

  validates_numericality_of :cantidad, :greater_than => 0

  before_save :set_precio_historico

  def validar_producto
    producto = Producto.find_by_nombre(self.nombre_de_producto.downcase)
    if producto.nil?
      errors.add(:nombre_de_producto, "inexistente")
    elsif producto.stock_real < self.cantidad
      errors.add(:cantidad, "es mayor que el stock del producto")
    else
      self.producto = producto
    end
  end

  def set_precio_historico
    self.precio_historico = self.producto.precio_unitario
  end

end
