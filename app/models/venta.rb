class Venta < ActiveRecord::Base

  #---Dependencia Existencial---
  belongs_to :pedido
  belongs_to :vendedor

  has_many :detalleventas, :dependent => :destroy
  has_one :credito, :dependent => :destroy
  has_one :pedido #agregar dependecia si se quiere eliminar el pedido al eliminar venta

  accepts_nested_attributes_for :credito, :reject_if => lambda {|a| a[:cliente_id].blank?}, :allow_destroy => true
  accepts_nested_attributes_for :detalleventas, :reject_if => lambda {|a| a[:nombre_de_producto].blank?}, :allow_destroy => true

  #validaciones

  validates_presence_of :vendedor_id
  validates_numericality_of :numero_boleta, :unless => "numero_boleta.nil?"
  validates_numericality_of :tipo_venta, :tipo_pago
  validates :tipo_venta, :inclusion => { :in => 0..2 }
  validates :tipo_pago, :inclusion => { :in => 0..2 }
  validates_uniqueness_of :numero_boleta, :unless => "numero_boleta.nil?"

  before_save :calcular_total_venta

  def calcular_total_venta
    self.total_venta = 0
    self.detalleventas.map do |d|
      self.total_venta += d.total_detalle
    end
    self.numero_boleta = nil if self.total_venta <= 180
    false if self.total_venta < 1
  end

end
