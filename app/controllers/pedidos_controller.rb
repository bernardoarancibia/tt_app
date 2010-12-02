class PedidosController < ApplicationController
  def index
    @pedidos = Pedido.order(:created_at)
  end

  def show
  end

  def destroy
  end

end
