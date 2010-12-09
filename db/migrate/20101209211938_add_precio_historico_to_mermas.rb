class AddPrecioHistoricoToMermas < ActiveRecord::Migration
  def self.up
    add_column :mermas, :precio_historico, :integer, :null => false
  end

  def self.down
    remove_column :mermas, :precio_historico
  end
end
