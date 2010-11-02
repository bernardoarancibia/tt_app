class CierreCaja < ActiveRecord::Base
  
  #---Dependencia Existencial---
  belongs_to :vendedor
  
  #---Atributos Accesibles---
  attr_accessible :vendedor_id, :total
  
  #---Validaciones---
  validates_numericality_of :total

end
