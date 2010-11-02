class ProductosController < ApplicationController

  def index
    @productos = Producto.order(:nombre)
  end

end
