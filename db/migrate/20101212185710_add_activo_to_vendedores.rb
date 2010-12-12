class AddActivoToVendedores < ActiveRecord::Migration
  def self.up
  add_column(:vendedores, :activo, :boolean, :default => true)
  end

  def self.down
  end
end
