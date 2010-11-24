class Credito < ActiveRecord::Base

  #---Dependencia Existencial---
  belongs_to :cliente
  belongs_to :venta

  attr_accessor :valor_interes_entero

  def valor_interes_entero= valor
    write_attribute(:valor_interes, (valor.to_f / 100) +1)
  end

  def self.valor_interes_entero
    (self.valor_interes * 100) -1
  end

end
