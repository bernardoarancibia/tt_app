class PedidosController < ApplicationController
  def index
    if params[:aceptado] == "true"
      @pedidos = Pedido.find_by_sql("SELECT * FROM pedidos, ventas WHERE pedidos.id = ventas.pedido_id")
    elsif params[:aceptado] == "false"
      @pedidos = Pedido.find_by_sql("SELECT * FROM pedidos, ventas WHERE ventas.pedido_id <> pedidos.id")
    elsif params[:cliente_id]
      @pedidos = Pedido.where(:cliente_id => params[:cliente])
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
