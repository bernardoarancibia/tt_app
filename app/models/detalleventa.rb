class Detalleventa < ActiveRecord::Base

  #---Dependencia Existencial---
  belongs_to :producto
  belongs_to :venta

end
