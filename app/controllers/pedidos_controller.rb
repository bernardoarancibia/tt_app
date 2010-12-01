class PedidosController < ApplicationController
  def index
    @pedidos = Pedido.order(:created_at)
  end

  def show
  end

  def destroy
  end

  def aceptar
    pedido = Pedido.find(params[:id])
    @venta = Venta.new
    @venta.vendedor_id = session[:vendedor_id]
    @venta.numero_boleta = 1234
    #asignar los valores de pedido @venta.new y llenar los que faltan
    #asignar los datos a detalleventas [ver NOMBRE DE PRODUCTO en el formulario]
    #render :new revisar!!!
  end
end
