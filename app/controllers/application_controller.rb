class ApplicationController < ActionController::Base
  protect_from_forgery

  protected #-------

  def es_administrador?
    @administrador = false
  end

  def administrador_pages
    if !@administrador
      flash[:notice] = 'Debe estar logeado'
      redirect_to :controller => 'pages'
    end
  end

  def administrador_vendedor_pages
  end

end
