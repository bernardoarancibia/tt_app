class ChangeDataTypeVendedoresClientes < ActiveRecord::Migration
  def self.up
  change_column(:vendedores, :num_fono, :integer)
  change_column(:clientes, :num_fono, :integer)
  end

  def self.down
  end
end
