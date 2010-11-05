class ChangeTableVendedor < ActiveRecord::Migration
  def self.up
  change_column(:vendedores, :administrador, :boolean, :default => false ) 
  end

  def self.down
  end
end
