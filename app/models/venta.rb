class Venta < ActiveRecord::Base

  #---Dependencia Existencial---
  belongs_to :vendedor

  has_many :detalleventas, :dependent => :destroy
  has_one :credito, :dependent => :destroy
  #has_one :pedido, :dependent => :destroy #agregar dependecia si se quiere eliminar el pedido al eliminar venta
  belongs_to :pedido, :dependent => :destroy

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

  def self.find_libro_ventas month, year
    ventas = Venta.where("extract(month from created_at) = ? AND extract(year from created_at) = ?", month, year).order(:created_at)
    ventas_grupo = ventas.group_by{|venta| venta.created_at.day}
    #ventas = Venta.find_by_sql("select extract(month from created_at), numero_boleta from ventas")
    #libro = []
    #ventas.each do |venta|
      #libro << {}
    #end
    return ventas_grupo
  end

end
