class AddForeignKeyVentas < ActiveRecord::Migration
  def self.up
    add_foreign_key(:ventas, :pedidos)
    add_foreign_key(:ventas, :vendedores)

    add_foreign_key(:detalleventas, :ventas)
    add_foreign_key(:detalleventas, :productos)
  end

  def self.down
    remove_foreign_key(:ventas, :pedidos)
    remove_foreign_key(:ventas, :vendedores)

    remove_foreign_key(:detalleventas, :ventas)
    remove_foreign_key(:detalleventas, :productos)
  end
end
