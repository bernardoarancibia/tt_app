class AddIndexToAll < ActiveRecord::Migration
  def self.up
    add_index :cierres_cajas, :vendedor_id
    add_index :notas, :vendedor_id
    add_index :productos, [:categoria_id, :proveedor_id]
    add_index :mermas, :producto_id
    add_index :ventas, [:pedido_id, :vendedor_id]
    add_index :detalleventas, [:venta_id, :producto_id]
    add_index :pedidos, :cliente_id
    add_index :detallepedidos, [:pedido_id, :producto_id]
    add_index :creditos, [:cliente_id, :venta_id]
  end

  def self.down
    remove_index :cierres_cajas, :vendedor_id
    remove_index :notas, :vendedor_id
    remove_index :productos, [:categoria_id, :proveedor_id]
    remove_index :mermas, :producto_id
    remove_index :ventas, [:pedido_id, :vendedor_id]
    remove_index :detalleventas, [:venta_id, :producto_id]
    remove_index :pedidos, :cliente_id
    remove_index :detallepedidos, [:pedido_id, :producto_id]
    remove_index :creditos, [:cliente_id, :venta_id]
  end
end
