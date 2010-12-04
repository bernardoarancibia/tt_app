#encoding: utf-8
class Credito < ActiveRecord::Base

  #---Dependencia Existencial---
  belongs_to :cliente
  belongs_to :venta

  attr_accessor :valor_interes_entero
  attr_accessor :nombre_de_cliente

  validates_presence_of :nombre_de_cliente

  before_validation :find_cliente

  def valor_interes_entero= valor
    write_attribute(:valor_interes, (valor.to_f / 100) +1)
  end

  def self.valor_interes_entero
    (self.valor_interes * 100) -100
  end

  def find_cliente
    cliente = Cliente.find_by_apellidos(self.nombre_de_cliente)
    if cliente.nil?
      errors.add(:nombre_de_cliente, "no es válido")
    else
      self.cliente = cliente
      #self.save
    end
  end

end

