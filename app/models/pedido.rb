class Pedido < ActiveRecord::Base

  #---Dependencia Existencial---
  belongs_to :venta
  belongs_to :cliente

  has_many :detallepedidos, :dependent => :destroy #eliminar un pedido

end
