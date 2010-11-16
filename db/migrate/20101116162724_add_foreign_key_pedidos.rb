class AddForeignKeyPedidos < ActiveRecord::Migration
  def self.up  
  
  add_foreign_key(:pedidos, :clientes)
  add_foreign_key(:detallepedidos, :pedidos)
  add_foreign_key(:detallepedidos, :productos)
  end

  def self.down

  remove_foreign_key(:pedidos, :clientes)
  remove_foreign_key(:detallepedidos, :pedidos)    
  remove_foreign_key(:detallepedidos, :productos)
  end
end
