# encoding: utf-8
class PedidosController < ApplicationController

  before_filter :vendedor_pages, :except => [:show]

  def index
    por_pagina = 10
    if params[:aceptado] == "true"
      @pedidos = find_pedidos_aceptados.paginate(:per_page => por_pagina, :page => params[:page])
    elsif params[:aceptado] == "1"
      @pedidos = Pedido.all.paginate(:per_page => por_pagina, :page => params[:page])
    elsif params[:cliente_id]
      @pedidos = Pedido.where(:cliente_id => params[:cliente]).paginate(:per_page => por_pagina, :page => params[:page])
    else
      @pedidos = find_pedidos_pendientes.paginate(:per_page => por_pagina, :page => params[:page])
    end
  end

  def show
      @pedido = Pedido.find(params[:id])
    unless session[:vendedor_id]
      if @pedido.cliente_id != session[:cliente_id]
        redirect_to :home, :notice => 'No está permitida esta acción.'
      end
    end
  end

  def destroy
    @pedido = Pedido.find(params[:id])
    if @pedido.venta
      redirect_to :pedidos, :notice => 'No se puede eliminar un pedido asociado a una venta'
    else
      @pedido.destroy
      redirect_to :pedidos, :notice => 'Se ha eliminado el pedido correctamente'
    end
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
