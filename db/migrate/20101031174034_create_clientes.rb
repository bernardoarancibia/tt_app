class CreateClientes < ActiveRecord::Migration
  def self.up
    create_table :clientes do |t|
      t.integer :rut, :unique => true, :null => false
      t.string :dv, :limit => 1, :null => false
      t.string :password, :limit => 15, :null => false
      t.boolean :activo, :default => true
      t.string :nombre, :limit => 40, :null => false
      t.string :apellidos, :limit => 40, :null => false
      t.string :direccion, :limit => 255
      t.integer :cod_fono, :limit => 2
      t.integer :num_fono, :limit => 3
      t.string :email, :limit => 255

      t.timestamps
    end
  end

  def self.down
    drop_table :clientes
  end
end
