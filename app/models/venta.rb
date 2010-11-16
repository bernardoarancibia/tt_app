class Venta < ActiveRecord::Base
  
  #---Dependencia Existencial---
  belongs_to :credito
  belongs_to :pedido
  belongs_to :vendedor

  has_many :detalleventas
  

end
