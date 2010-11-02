class Producto < ActiveRecord::Base

  belongs_to :categoria
  belongs_to :proveedor

end
