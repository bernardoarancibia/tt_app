class CreateVentas < ActiveRecord::Migration
  def self.up
    create_table :ventas do |t|
      t.integer :pedido_id
      t.integer :vendedor_id, :null => false
      t.integer :numero_boleta
      t.integer :total_venta, :null => false
      t.integer :tipo_venta, :limit => 2, :null => false
      t.integer :tipo_pago, :limit => 2, :default => 0, :null => false

      t.timestamps

    end
  end

  def self.down
    drop_table :ventas
  end
end
