class AddTotalCreditoToCreditos < ActiveRecord::Migration
  def self.up
  add_column(:creditos, :total_creditos, :integer)
  end

  def self.down
  end
end
