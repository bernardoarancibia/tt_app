class Venta < ActiveRecord::Base

  #---Dependencia Existencial---
  belongs_to :credito
  belongs_to :pedido
  belongs_to :vendedor

  has_many :detalleventas

  #validar existencia de productos
  #validar stocks y cantidades

end
