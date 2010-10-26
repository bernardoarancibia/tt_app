#encoding: utf-8

class CreateCategorias < ActiveRecord::Migration
  def self.up
    create_table :categorias do |t|
      t.string :nombre, :limit => 40, :unique =>true, :null => false
    end
    Categoria.create :nombre => 'Sin Categoría'
  end

  def self.down
    drop_table :categorias
  end
end
