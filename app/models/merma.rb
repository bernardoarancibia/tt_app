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

  def validar_producto
    producto = Producto.find_by_nombre(self.nombre_de_producto.downcase)
    if producto.nil?
      errors.add_to_base("Debe ingresar un producto existente")
    elsif producto.stock_real < self.cantidad
      errors.add_to_base("No hay stock suficiente para realizar la operación")
    else
      self.producto = producto
    end
  end

end
