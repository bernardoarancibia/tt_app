class Credito < ActiveRecord::Base

  #---Dependencia Existencial--- 
  belongs_to :cliente 
  belongs_to :venta 

end
