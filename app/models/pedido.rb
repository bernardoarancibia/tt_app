class Pedido < ActiveRecord::Base

  #---Dependencia Existencial---
  belongs_to :venta
  belongs_to :cliente

  has_many :detallepedidos, :dependent => :destroy #eliminar un pedido

  def aceptado?
    if Venta.where("pedido_id = ?", self.id).empty?
      return false
    else
      return true
    end
  end

end
