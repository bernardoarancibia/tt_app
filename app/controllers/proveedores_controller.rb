#encoding: utf-8
#
class ProveedoresController < ApplicationController

  def index
    @proveedores = Proveedor.order(:name)
  end

end
