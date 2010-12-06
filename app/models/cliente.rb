#encoding: utf-8
class Cliente < ActiveRecord::Base

  #---Dependencia Existencial---
  has_many :pedidos
  has_many :creditos

  #---Atributos Accesibles---
  #attr_accessible :rut, :dv, :password, :activo, :nombre, :apellidos,
  #                :direccion, :cod_fono, :num_fono, :email

  #---Antes de guardar en la BD---

  before_save :downcase_attributes

  #---Validaciones---

  #validates :rut, :numericality => true, :presence => true, :uniqueness => true

  validates_numericality_of :rut

  validates_uniqueness_of :rut

  validates_format_of :dv, :with => /^[0-9kK]/

  #Validacion de rut
  validate :rut_valida

  #validates :dv, :format => { :with => /^[0-9kK]/ }, :length => { :maximum => 1 }

  validates :password, :length => { :maximum => 15 }

  validates_format_of :nombre, :with => /^([a-zA-Z áéíóúñÁÉÍÓÚÜÑ]{1,})([a-zA-ZñáéíóúÁÉÍÓÚÜüÑ])$/

  validates_length_of :nombre, :maximum => 40

  validates_format_of :apellidos, :with => /^([a-zA-Z áéíóúñÁÉÍÓÚÜÑ]{1,})([a-zA-ZñáéíóúÁÉÍÓÚÜüÑ])$/

  validates_length_of :apellidos, :maximum => 40

  #validates :nombre, :length => {:maximum => 40}, :presence => true, :format => { :with => /^([a-zA-Z áéíóúñÁÉÍÓÚÜÑ]{1,})([a-zA-ZñáéíóúÁÉÍÓÚÜüÑ])$/}

  #validates :apellidos, :length => {:maximum => 40}, :presence => true, :format => { :with => /^([a-zA-Z áéíóúñÁÉÍÓÚÜÑ]{1,})([a-zA-ZñáéíóúÁÉÍÓÚÜüÑ])$/}

  validates :direccion, :length => { :maximum => 255 }

  validates :cod_fono , :numericality => true, :length => { :maximum => 9 }, :allow_blank => true

  validates :num_fono , :numericality => true, :length => { :maximum => 8 }, :allow_blank => true

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

end
