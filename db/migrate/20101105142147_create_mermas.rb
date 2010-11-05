class CreateMermas < ActiveRecord::Migration
  def self.up
    create_table :mermas do |t|
      t.integer :producto_id, :null => false
      t.integer :cantidad, :null => false
      t.integer :tipo_merma, :null => false, :limit => 2
      t.text :comentario

      t.timestamps
    end
    add_foreign_key(:mermas, :productos)
  end

  def self.down
    remove_foreign_key(:mermas, :productos)
    drop_table :mermas
  end
end
