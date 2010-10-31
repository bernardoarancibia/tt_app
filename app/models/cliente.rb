#encoding: utf-8
class Cliente < ActiveRecord::Base
  
  #---Dependencia Existencial---
  
  #---Atributos Accesibles---
  attr_accessible :rut, :dv, :password, :activo, :nombre, :apellidos,
                  :direccion, :cod_fono, :num_fono, :email

  #---Antes de guardar en la BD---
  
  before_save :downcase_attributes

  #---Validaciones---
  
  validates_numericality_of :rut
  validates_uniqueness_of :rut
  #Validacion de rut
  #Validate rut_valida

  validates_format_of :dv, :with => /^[1-9kK]/
  validates_length_of :dv, :maximum => 1

  validates_length_of :password, :maximum => 15

  validates_length_of :nombre, :maximum => 40

  validates_length_of :apellidos, :maximum => 40

  validates_length_of :direccion, :maximum => 255

  validates_numericality_of :cod_fono, :num_fono  

  validates_format_of :email, :with => /^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-z]{2,4}$/, :allow_blank => true


  private #--------

  def downcase_attributes
    self.nombre.downcase!
    self.dv.downcase!
    self.apellidos.downcase!
    self.direccion.downcase!
    self.email.downcase!
  end


end
