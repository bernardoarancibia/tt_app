#encoding: utf-8
class Credito < ActiveRecord::Base

  #---Dependencia Existencial---
  belongs_to :cliente
  belongs_to :venta

  attr_accessor :valor_interes_entero

  validates_presence_of :cliente_id
  validates_presence_of :fecha_pago
  validates_date :fecha_pago, :on_or_after => lambda { Date.current }

  # Falta agregar fecha por defecto, 1 mes + de la fecha actual

  def valor_interes_entero= valor
    write_attribute(:valor_interes, (valor.to_f / 100) +1)
  end

  def self.valor_interes_entero
    (self.valor_interes * 100) -100
  end

end

