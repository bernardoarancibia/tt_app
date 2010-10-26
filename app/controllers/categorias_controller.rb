#encoding: utf-8
class CategoriasController < ApplicationController
  
  before_filter :find_categoria, :only => [:edit, :update, :destroy]

  def index
    @categorias = Categoria.order(:nombre)
  end

  def list
  end  

  def new
    @categoria = Categoria.new  
  end

  def create
    @categoria = Categoria.new(params[:categoria])
    if @categoria.save
      redirect_to :categorias, :notice => 'Se ha ingresado la categoría correctamente'
    else
      render :new
    end
  end

  def edit
  end

  def update 
    if @categoria.update_attributes(params[:categoria])
      redirect_to :categorias, :notice => 'Se ha modificado la categoría correctamente'
    else
      render :edit
    end
  end  

  def destroy
    if @categoria.length == 0
      @categoria.destroy
      redirect_to :categorias, :notice => 'Se ha eliminado la categoría correctamente'
    else
      redirect_to :categorias, :notice => 'La categoría no pudo ser eliminada, ya que posee productos asociados'
    end
  end

  def productos
    @productos = Productos.find(:all, :conditions => ["categoria_id => ?", params[:id]])
    redirect_to :controller => :productos, :action => :index
  end

  private #-------------

  def find_categoria
    @categoria = Categoria.find_by_id(params[:id])
  end

end
