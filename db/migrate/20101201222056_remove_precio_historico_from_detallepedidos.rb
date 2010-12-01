class RemovePrecioHistoricoFromDetallepedidos < ActiveRecord::Migration
  def self.up
    # borro :precio_historico, ya que no es necesario y no cumple una funcion
    remove_column :detallepedidos, :precio_historico
  end

  def self.down
  end
end
