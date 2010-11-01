#encoding: utf-8

class Proveedor < ActiveRecord::Base
  #has_many :productos

  attr_accessible :nombre, :cod_fono,
                  :num_fono, :email, :nombre_encargado, :apellidos_encargado

  validates :nombre, :uniqueness => true, :length => { :maximum => 40},
                     :format => { :with => /^([A-Za-z0-9ÁÉÍÓÚáéíóúÑÜñü]{1,})([ A-Za-z0-9ÁÉÍÓÚáéíóúÑÜñü\/&-]{1,})$/ },
                     :allow_nil => false
  validates :cod_fono, :num_fono , :numericality => true

  validates_format_of :email, :with => /^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-z]{2,4}$/,
            #:if => "email.nil?",
            :allow_blank => true

  #validates :email, :format =>{ :with => /^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-z]{2,4}$/},
  #          :unless => "email.nil?", :allow_nil => true

  validates :nombre_encargado, :apellidos_encargado, :length => { :maximum =>40 },
            :format => {:with => /^([A-Za-zÁÉÍÓÚáéíóúÑÜñü]{1,})([ A-Za-zÁÉÍÓÚáéíóúÑÜñü]{1,})$/ },
            :allow_blank => true

  before_validation :downcase_nombre

  protected #--------

  def downcase_nombre
    self.nombre.downcase!
  end
end
