class Detallepedido < ActiveRecord::Base

  #---Dependencia Existencial---
  belongs_to :producto
  belongs_to :pedido

end
