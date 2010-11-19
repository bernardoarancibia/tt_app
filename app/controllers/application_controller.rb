#encoding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery

  protected #-------

  def es_administrador?
    # aquí debe ir el accesso a bd y variable de sesion
    #session[:usuario_id]
    @administrador = true
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
