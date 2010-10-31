#encoding: utf-8
class Categoria < ActiveRecord::Base
  
  #---Dependencia existencial---
    has_many :productos
  
  #---Atributos accesibles---
    attr_accessible :nombre
  
  #---Antes de validar---
    before_validation :downcase_nombre
  
  #---Validaciones---
    validates_presence_of :nombre
    validates_uniqueness_of :nombre
    validates_length_of :nombre, :maximum => 40    
    validates_format_of :nombre, :with => /^([a-zA-Z áéíóúñÁÉÍÓÚÜÑ]{1,})([a-zA-ZñáéíóúÁÉÍÓÚÜüÑ])$/
  
  #---Metodos---
    protected #---------------------
    
    def downcase_nombre
      self.nombre.downcase!
    end

end
