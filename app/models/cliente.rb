#encoding: utf-8
class Cliente < ActiveRecord::Base

  #---Dependencia Existencial---
  has_many :pedidos
  has_many :creditos

  #---Atributos Accesibles---
  #attr_accessible :rut, :dv, :password, :activo, :nombre, :apellidos,
  #                :direccion, :cod_fono, :num_fono, :email
  
  attr_accessor :password_confirma

  #---Antes de guardar en la BD---

  before_save :downcase_attributes

  #---Validaciones---

  #validates :rut, :numericality => true, :presence => true, :uniqueness => true
  
  validates_presence_of :password, :password_confirma

  validates_numericality_of :rut, :greater_than_or_equal_to => 0

  validates_uniqueness_of :rut

  validates_format_of :dv, :with => /^[0-9kK]/

  #Validacion de rut
  validate :rut_valida

  #validacion de password

  validate :password_valida

  #validates :dv, :format => { :with => /^[0-9kK]/ }, :length => { :maximum => 1 }

  validates :password, :length => { :minimum => 6, :maximum => 15 }

  validates_format_of :nombre, :with => /^([a-zA-Z áéíóúñÁÉÍÓÚÜÑ]{1,})([a-zA-ZñáéíóúÁÉÍÓÚÜüÑ])$/

  validates_length_of :nombre, :maximum => 40

  validates_format_of :apellidos, :with => /^([a-zA-Z áéíóúñÁÉÍÓÚÜÑ]{1,})([a-zA-ZñáéíóúÁÉÍÓÚÜüÑ])$/

  validates_length_of :apellidos, :maximum => 40

  #validates :nombre, :length => {:maximum => 40}, :presence => true, :format => { :with => /^([a-zA-Z áéíóúñÁÉÍÓÚÜÑ]{1,})([a-zA-ZñáéíóúÁÉÍÓÚÜüÑ])$/}

  #validates :apellidos, :length => {:maximum => 40}, :presence => true, :format => { :with => /^([a-zA-Z áéíóúñÁÉÍÓÚÜÑ]{1,})([a-zA-ZñáéíóúÁÉÍÓÚÜüÑ])$/}

  validates :direccion, :length => { :maximum => 255 }

  validates_numericality_of :cod_fono , :greater_than_or_equal_to => 0, :allow_blank => true
  validates_numericality_of :num_fono , :greater_than_or_equal_to => 0, :allow_blank => true

  validates_format_of :email, :with => /^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-z]{2,4}$/, :allow_blank => true


  private #--------

  def downcase_attributes
    self.dv.downcase!
    self.direccion.downcase!
    self.email.downcase!
  end

  def nombre_completo
    "#{self.apellidos} #{self.nombre}"
  end

  def rut_valida
    x=9
    t=0
    rut = self.rut.to_s
    rut.reverse.split(//).each { |d| t+=d.to_i*x; x=(x==4) ? 9 : x - 1;}
    r= t % 11
    if r==10
      r = "k"
    end

    unless r.to_s == self.dv.downcase
      errors.add_to_base("Rut Inválido")
      #errors.add(:rut,"no es válido")
      #errors.add(:dv,"no es válido")
    end
  end

  def password_valida
    if self.password != self.password_confirma
      errors.add(:password, "no coincide, verifique que esté bien escrito")
    end
  end

end
