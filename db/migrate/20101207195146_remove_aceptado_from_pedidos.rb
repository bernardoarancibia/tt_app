class RemoveAceptadoFromPedidos < ActiveRecord::Migration
  def self.up
    remove_column :pedidos, :aceptado
  end

  def self.down
  end
end
