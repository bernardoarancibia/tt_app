class Venta < ActiveRecord::Base

  #---Dependencia Existencial---
  belongs_to :pedido
  belongs_to :vendedor

  has_many :detalleventas, :dependent => :destroy #actualizar stock de productos
  has_one :credito, :dependent => :destroy

  accepts_nested_attributes_for :credito, :reject_if => lambda {|a| a[:cliente_id].blank?}, :allow_destroy => true
  accepts_nested_attributes_for :detalleventas, :reject_if => lambda {|a| a[:nombre_de_producto].blank?}, :allow_destroy => true

  #validaciones
  # validar vendedor_id que exista
  validates_presence_of :vendedor_id
  validates_numericality_of :numero_boleta, :unless => "numero_boleta.nil?"
  validates_numericality_of :tipo_venta, :tipo_pago
  validates :tipo_venta, :inclusion => { :in => 0..2 }
  validates :tipo_pago, :inclusion => { :in => 0..2 }
  validates_uniqueness_of :numero_boleta, :unless => "numero_boleta.nil?"
  #validates_numericality_of :total_venta, :greater_than => 0, :message => "debe ser calculado con al menos un producto"

  before_save :calcular_total_venta

  #validar existencia de productos
  #validar stocks y cantidades


  def calcular_total_venta
    self.total_venta = 0
    self.detalleventas.map do |d|
      self.total_venta += d.total_detalle
    end
    false if self.total_venta < 1
  end

end
