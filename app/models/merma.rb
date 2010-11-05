class Merma < ActiveRecord::Base

  #---Dependencia Existencial---
  belongs_to :producto

  #---Atributos Accesibles---
  attr_accessible :producto_id, :cantidad, :tipo_merma, :comentario

  #---Validaciones---
  validates_numericality_of :cantidad, :tipo_merma
end
