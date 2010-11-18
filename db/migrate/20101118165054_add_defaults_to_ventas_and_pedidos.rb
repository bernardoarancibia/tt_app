class AddDefaultsToVentasAndPedidos < ActiveRecord::Migration
  def self.up

    change_column :ventas, :tipo_venta, :integer, :limit => 2, :default => 0, :null => false
    change_column :detalleventas, :cantidad, :integer, :default => 1, :null => false
    change_column :detallepedidos, :cantidad, :integer, :default => 1, :null => false

  end

  def self.down
  end
end
