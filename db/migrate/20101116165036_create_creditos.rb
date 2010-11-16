class CreateCreditos < ActiveRecord::Migration
  def self.up
    create_table :creditos do |t|
      t.integer :cliente_id, :null => false
      t.integer :venta_id, :null => false
      t.decimal :valor_interes, :precision => 3, :scale => 2
      t.date :fecha_pago, :null => false

      t.timestamps
    end
    add_foreign_key(:creditos,:ventas)
    add_foreign_key(:creditos,:clientes)
  end

  def self.down
    remove_foreign_key(:creditos,:ventas)
    remove_foreign_key(:creditos,:clientes)
    drop_table :creditos
  end
end
