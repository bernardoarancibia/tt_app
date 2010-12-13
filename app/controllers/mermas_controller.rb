#encoding: utf-8
class MermasController < ApplicationController

  before_filter :vendedor_pages
  before_filter :find_mermas, :only => [:edit, :update, :destroy]
  before_filter :find_productos, :only => [:new, :create, :edit, :update]

  def index
    @productos = Producto.all
    por_pagina = 10
    if params[:tipo_merma]
      if params[:tipo_merma] == "4"
        @mermas = Merma.order(:updated_at).paginate(:per_page => por_pagina, :page => params[:page])
      else
        @mermas = Merma.where("tipo_merma = ?", params[:tipo_merma]).order(:updated_at).paginate(:per_page => por_pagina, :page => params[:page])
      end
    elsif params[:producto]
      @mermas = Merma.where("producto_id = ?", params[:producto]).order(:updated_at).paginate(:per_page => por_pagina, :page => params[:page])
    else
      @mermas = Merma.order(:updated_at).paginate(:per_page => por_pagina, :page => params[:page])
    end
  end

  def list
  end

  def new
    @productos = Producto.all
    @merma = Merma.new
  end

  def create
    @productos = Producto.all
    @merma = Merma.new(params[:merma])
    if @merma.save
      redirect_to :mermas, :notice => 'Se ha ingresado la merma correctamente'
      ajuste_stock_decremento @merma
    else
      render :new
    end
  end

  def edit
    @productos = Producto.all
    @merma.nombre_de_producto = Producto.find_by_id(@merma.producto_id).nombre
  end

  def update
    ajuste_stock_decremento @merma
    if @merma.update_attributes(params[:merma])
      redirect_to :mermas, :notice => 'Se ha modificado la merma correctamente'
    else
      render :edit
    end
  end

  def destroy
      @merma.destroy
      ajuste_stock_incremento @merma
      redirect_to :mermas, :notice => 'Se ha eliminado la merma correctamente'
  end

  def productos
    @productos = Producto.find(:all, :conditions => ["producto_id = ?", params[:id]])
    redirect_to :controller => :mermas, :action => :index
  end

  def buscar
    nombre = params[:buscar].downcase
    @producto =  Producto.find_by_nombre(nombre)
    if @producto.nil?
      redirect_to :mermas, :notice => 'No se encontró la merma buscada'
    else
      redirect_to :controller => :mermas, :producto => @producto.id
    end
  end

  def ajuste_stock_incremento merma
    producto = Producto.find(merma.producto_id)
    producto.stock_real += merma.cantidad
    producto.save
  end

  def ajuste_stock_decremento merma
    producto = Producto.find(merma.producto_id)
    producto.stock_real -= merma.cantidad
    producto.save
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
