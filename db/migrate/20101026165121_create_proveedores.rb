class CreateProveedores < ActiveRecord::Migration
  def self.up
    create_table :proveedores do |t|
      t.string :nombre, :limit => 40, :null => false
      t.integer :cod_fono, :limit => 2, :null => false
      t.integer :num_fono, :null => false
      t.string :email, :limit => 255
      t.string :nombre_encargado, :limit => 40
      t.string :apellidos_encargado, :limit => 40

      t.timestamps
    end
  end

  def self.down
    drop_table :proveedores
  end
end
