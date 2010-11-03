#encoding: utf-8

class Producto < ActiveRecord::Base

  belongs_to :categoria
  belongs_to :proveedor

  before_validation :downcase_nombre

  validates :nombre, :length => { :maximum => 40 }
  validates_format_of :nombre,
    :with => /^([A-Za-z0-9ÁÉÍÓÚáéíóúÑÜñü]{1,})([ A-Za-z0-9ÁÉÍÓÚáéíóúÑÜñü\/&-]{1,})$/, :allow_nil => true

  validates_uniqueness_of :nombre, :case_sensitive => false

  validates_numericality_of :precio_unitario,
    :less_than => 9999999, :greater_than_or_equal_to => 1

  validates_presence_of :stock_real, :stock_critico

  validates_numericality_of :stock_real,
    :less_than => 99999, :greater_than_or_equal_to => 1,
    :unless => "stock_real.nil?"

  validates_numericality_of :stock_critico,
    :less_than => 99999, :greater_than_or_equal_to => 1,
    :unless => "stock_critico.nil?"

  validate :diferencia_stocks

  protected #-----

  def diferencia_stocks
    unless stock_critico.nil? || stock_real.nil?
      errors.add(:stock_real, "debe ser mayor que el stock crítico") if
      stock_critico >= stock_real
    end
  end

  def downcase_nombre
    self.nombre.downcase!
  end

end
