class CreateProductos < ActiveRecord::Migration
  def self.up
    create_table :productos do |t|
      t.integer :categoria_id, :null => false
      t.integer :proveedor_id, :null => false
      t.string :nombre, :limit => 40, :null => false
      t.boolean :granel, :null => false, :default => false
      t.integer :precio_unitario, :null => false
      t.integer :stock_real, :null => false
      t.integer :stock_critico, :null => false

      t.timestamps
    end

    add_foreign_key(:productos, :categorias)
    add_foreign_key(:productos, :proveedores)
  end

  def self.down
    remove_foreign_key(:productos, :categorias)
    remove_foreign_key(:productos, :proveedores)
    drop_table :productos
  end
end
