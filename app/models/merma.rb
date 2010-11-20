#encoding:utf-8
class Merma < ActiveRecord::Base

  #---Dependencia Existencial---
  belongs_to :producto  
  
  #---Crear campo nombre_de_producto---
  attr_accessor :nombre_de_producto

  #---Atributos Accesibles---
  attr_accessible :producto_id, :cantidad, :tipo_merma, :comentario, :nombre_de_producto

  #---validar producto
  validate :validar_producto
  #before_validation :validar_producto
  
  
  #---Validaciones---
  validates_numericality_of :cantidad, :tipo_merma
  validates_presence_of :nombre_de_producto


  def validar_producto
    producto = Producto.find_by_nombre(self.nombre_de_producto.downcase)
    if producto.nil?
      errors.add(:nombre_de_producto, "no es válido")
    else
      self.producto = producto
    end
  end

end
