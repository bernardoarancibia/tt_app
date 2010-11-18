class Venta < ActiveRecord::Base

  #---Dependencia Existencial---
  belongs_to :credito
  belongs_to :pedido
  belongs_to :vendedor

  has_many :detalleventas, :dependent => :destroy #actualizar stock de productos

  accepts_nested_attributes_for :detalleventas, :reject_if => lambda {|a| a[:nombre_de_producto].blank?}

  validates_presence_of :vendedor_id

  before_save :calcular_total_venta


  #validar existencia de productos
  #validar stocks y cantidades

  private #-----

  def calcular_total_venta
    self.total_venta = 0
    self.detalleventas.map do |d|
      self.total_venta += d.total_detalle
    end
  end

end
