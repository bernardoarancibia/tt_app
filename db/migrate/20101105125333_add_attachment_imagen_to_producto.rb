class AddAttachmentImagenToProducto < ActiveRecord::Migration
  def self.up
    add_column :productos, :imagen_file_name, :string
    add_column :productos, :imagen_content_type, :string
    add_column :productos, :imagen_file_size, :integer
    add_column :productos, :imagen_updated_at, :datetime
  end

  def self.down
    remove_column :productos, :imagen_file_name
    remove_column :productos, :imagen_content_type
    remove_column :productos, :imagen_file_size
    remove_column :productos, :imagen_updated_at
  end
end
