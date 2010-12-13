#encoding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :es_administrador?
  before_filter :es_vendedor?
  before_filter :es_cliente?

  protected #-------

  # Reconocimiento de Administrador
  def es_administrador?
    if session[:vendedor_id]
      vendedor = Vendedor.find(session[:vendedor_id])
      if vendedor.administrador?
        @administrador = true
      end
    end
  end

  # Reconocimiento de Vendedor Simple
  def es_vendedor?
    if session[:vendedor_id]
      vendedor = Vendedor.find(session[:vendedor_id])
      @session = vendedor
      count_pedidos
      if vendedor
        @vendedor = true
      end
    end
  end

  def es_cliente?
    if session[:cliente_id]
      cliente = Cliente.find(session[:cliente_id])
      @session = cliente
      if cliente
        @cliente = true
      end
    end
  end

  # Accesos --------

  # Páginas con acceso sólo Administrador
  def administrador_pages
    unless es_administrador?
      flash[:notice] = 'Esta página tiene acceso privado, por favor identifíquese.'
      redirect_to :login_ventas
    end
  end

  # Páginas con acceso sólo Vendedor
  def vendedor_pages
    unless es_vendedor?
      flash[:notice] = 'Esta página tiene acceso privado, por favor identifíquese.'
      redirect_to :login_ventas
    end
  end

  def cliente_pages
    unless es_cliente?
      flash[:notice] = 'Esta página tiene acceso privado, por favor identifíquese.'
      redirect_to :login_clientes
    end
  end

  def count_pedidos
    pedidos = Pedido.all
    count = 0
    pedidos.each do |p|
      count += 1 unless p.aceptado?
    end
    @count_pedidos = count
    return @count_pedidos
  end

end
