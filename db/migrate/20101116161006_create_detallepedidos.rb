class CreateDetallepedidos < ActiveRecord::Migration
  def self.up
    create_table :detallepedidos do |t|
      t.integer :pedido_id, :null => false
      t.integer :producto_id, :null => false
      t.integer :precio_historico, :null => false
      t.integer :cantidad, :null => false
      t.integer :total_detalle, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :detallepedidos
  end
end
