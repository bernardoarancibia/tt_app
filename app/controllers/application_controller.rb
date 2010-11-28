#encoding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :es_administrador?
  before_filter :es_vendedor?

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
      if vendedor
        @vendedor = true
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

end
