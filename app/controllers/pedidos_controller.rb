class PedidosController < ApplicationController
  def index
    if params[:aceptado]
      @pedidos = Pedido.where("aceptado = ?",params[:aceptado])
    elsif params[:cliente]
      @pedidos = Pedido.where("cliente_id = ?",params[:cliente])
    else
      @pedidos = Pedido.order(:created_at)
    end
  end

  def show
    @pedido = Pedido.find(params[:id])
  end

  def destroy
    @pedido = Pedido.find(params[:id])
    @pedido.destroy
    redirect_to :pedidos, :notice => 'Se ha eliminado el pedido correctamente'
  end

end
