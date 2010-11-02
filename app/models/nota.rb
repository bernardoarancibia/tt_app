class Nota < ActiveRecord::Base
  
  #---Dependencia Existencial--- 
  belongs_to :vendedor

  #---Atributos Accesibles---
  attr_accessible :vendedor_id, :texto
end
