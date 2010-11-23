#encoding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery

  protected #-------

  def es_administrador?
    if session[:vendedor_id]
      vendedor = Vendedor.find(session[:vendedor_id])
      if vendedor.administrador?
        @administrador = true
      end
    end
  end

  def administrador_pages
    unless es_administrador?
      flash[:notice] = 'Esta página tiene acceso limitado.'
      redirect_to :controller => 'pages'
    end
  end

  def administrador_vendedor_pages
  end

end
