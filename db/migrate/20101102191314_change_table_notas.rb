class ChangeTableNotas < ActiveRecord::Migration
  def self.up
  change_column(:notas, :vendedor_id, :integer, :null => false )
  change_column(:notas, :texto ,:text, :null => false )
  end

  def self.down
  
  end
end
