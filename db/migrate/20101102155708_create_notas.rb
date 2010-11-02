class CreateNotas < ActiveRecord::Migration
  def self.up
    create_table :notas do |t|
      t.integer :vendedor_id
      t.text :texto

      t.timestamps
    end
  end

  def self.down
    drop_table :notas
  end
end
