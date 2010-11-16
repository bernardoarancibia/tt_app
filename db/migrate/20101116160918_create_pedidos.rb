class CreatePedidos < ActiveRecord::Migration
  def self.up
    create_table :pedidos do |t|
      t.integer :cliente_id, :null => false
      t.integer :total_pedido, :null => false
      t.boolean :aceptado, :default => false, :null => false
      t.text :comentario

      t.timestamps
    end
  end

  def self.down
    drop_table :pedidos
  end
end
