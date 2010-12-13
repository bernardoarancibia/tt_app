class CierresCajasController < ApplicationController

  before_filter :vendedor_pages
  before_filter :find_cierre_caja, :only => [:edit, :update, :destroy]

  def index
     @cierres_cajas = CierreCaja.order(:updated_at)
  end

  def list
  end

  def new
    @cierre_caja = CierreCaja.new
  end

  def create
    @cierre_caja = CierreCaja.new(params[:cierre_caja])
    @cierre_caja.vendedor_id = session[:vendedor_id]
    if @cierre_caja.save
      redirect_to :cierres_cajas, :notice => 'Se ha cerrado la caja correctamente'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @cierre_caja.update_attributes(params[:cierre_caja])
      redirect_to :cierres_cajas, :notice => 'Se ha modificado el cierre de caja correctamente'
    else
      render :edit
    end
  end

  def destroy
      @cierre_caja.destroy
      redirect_to :cierres_cajas, :notice => 'Se ha eliminado el cierre de caja correctamente'
  end

  def vendedores
    @cierres_cajas = CierresCajas.find(:all, :conditions => ["vendedor_id = ?", params[:id]])
    redirect_to :controller => :cierres_cajas, :action => :index
  end

  private #-------------

  def find_cierre_caja
    @cierre_caja = CierreCaja.find_by_id(params[:id])
  end


end
