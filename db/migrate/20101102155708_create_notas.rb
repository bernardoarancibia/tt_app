class CreateNotas < ActiveRecord::Migration
  def self.up
    create_table :notas do |t|
      t.integer :vendedor_id
      t.text :texto

      t.timestamps
    end
    add_foreign_key(:notas, :vendedores)
  end

  def self.down
    remove_foreign_key(:notas, :vendedores)
    drop_table :notas
  end
end
