class PedidosController < ApplicationController
  def index
    @pedidos = Pedido.order(:created_at)
  end

  def show
  end

  def destroy
    @pedido = Pedido.find(params[:id])
    @pedido.destroy
    redirect_to :pedidos, :notice => 'Se ha eliminado el pedido correctamente'
  end

end
