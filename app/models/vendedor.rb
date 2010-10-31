class Vendedor < ActiveRecord::Base
  
  #---Dependencia Existencial---
  
  #---Atributos Accesibles---
  attr_accessible :rut, :dv, :password, :administrador, :nombre, :apellidos,
                  :direccion, :cod_fono, :num_fono, :email

  #---Validaciones---
  
  validates_numericality_of :rut
  validates_uniqueness_of :rut
  #Validacion de rut
  #Validate rut_valida

  validates_format_of :dv, :with => /^[1-9k]/
  validates_length_of :dv, :maximum => 1

  validates_length_of :password, :maximum => 15

  validates_length_of :nombre, :maximum => 40

  validates_length_of :apellidos, :maximum => 40

  validates_length_of :direccion, :maximum => 255

  validates_numericality_of :cod_fono, :num_fono  

  validates_format_of :email, :with => /^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-z]{2,4}$/, :allow_blank => true

end
