#encoding: utf-8
class MermasController < ApplicationController
  before_filter :find_mermas, :only => [:edit, :update, :destroy]
  before_filter :find_productos, :only => [:new, :create, :edit, :update]

  def index
     @mermas = Merma.order(:updated_at)
  end

  def list
  end  

  def new
    @merma = Merma.new  
  end

  def create
    @merma = Merma.new(params[:merma])
    if @merma.save
      redirect_to :mermas, :notice => 'Se ha ingresado la merma correctamente'
    else
      render :new
    end
  end

  def edit
  end

  def update 
    if @merma.update_attributes(params[:merma])
      redirect_to :mermas, :notice => 'Se ha modificado la merma correctamente'
    else
      render :edit
    end
  end  

  def destroy
      @merma.destroy
      redirect_to :mermas, :notice => 'Se ha eliminado la merma correctamente'
  end

  def productos
    @productos = Producto.find(:all, :conditions => ["producto_id = ?", params[:id]])
    redirect_to :controller => :mermas, :action => :index
  end


  private #-------------

  def find_mermas
    @merma = Merma.find_by_id(params[:id])
  end

  def find_productos
    @productos = Producto.order(:nombre)

    if @productos.length == 0
      redirect_to :mermas, :notice => 'Verifique que exista al menos un producto ingresado en el sistema.'
    end
  end

end
