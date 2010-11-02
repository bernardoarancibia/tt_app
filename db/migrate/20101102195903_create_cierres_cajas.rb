class CreateCierresCajas < ActiveRecord::Migration
  def self.up
    create_table :cierres_cajas do |t|
      t.integer :vendedor_id, :null => false
      t.integer :total, :null => false

      t.timestamps
    end
    add_foreign_key(:cierres_cajas, :vendedores)
  end

  def self.down
    remove_foreign_key(:cierres_cajas, :vendedores)
    drop_table :cierres_cajas
  end
end
