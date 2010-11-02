class CierreCaja < ActiveRecord::Base
  
  #---Dependencia Existencial---
  belongs_to :vendedor

end
