class PedidosController < ApplicationController
  def index
    if params[:aceptado] == "true"
      @pedidos = find_pedidos_aceptados
    elsif params[:cliente_id]
      @pedidos = Pedido.where(:cliente_id => params[:cliente])
    else
      @pedidos = find_pedidos_pendientes
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

  private #-------

  def find_pedidos_aceptados
    pedidos = Pedido.all
    pedidos_aceptados = []
    pedidos.each do |p|
       pedidos_aceptados << p if p.aceptado?
    end
    return pedidos_aceptados
  end

  def find_pedidos_pendientes
    pedidos = Pedido.all
    pedidos_pendientes = []
    pedidos.each do |p|
      pedidos_pendientes << p unless p.aceptado?
    end
    return pedidos_pendientes
  end

end
