# encoding: utf-8

class ProductosController < ApplicationController

  # sesiones, cache y páginas privadas
  before_filter :es_administrador?
  before_filter :administrador_pages, :only =>  [:edit]

  # acceso a la base de datos común
  before_filter :find_producto, :only => [:edit, :update, :destroy]
  before_filter :find_proveedores_categorias, :only => [:new, :create, :edit, :update]

  def index
    if params[:categoria]
      @productos = Producto.where(["categoria_id = ?", params[:categoria]])
    elsif params[:proveedor]
      @productos = Producto.where(["proveedor_id = ?", params[:proveedor]])
    else
      @productos = Producto.order(:nombre)
    end
  end

  def show
    @producto = Producto.find(params[:id])
  end

  def new
    @producto = Producto.new
  end

  def create
    @producto = Producto.new(params[:producto])
    if @producto.save
      redirect_to :productos, :notice => 'El producto fue ingresado exitosamente.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @producto.update_attributes(params[:producto])
      redirect_to :productos, :notice => 'El producto fue actualizado exitosamente.'
    else
      render :edit
    end
  end

  def destroy
    @producto.destroy
    redirect_to :productos, :notice => 'El producto fue eliminado exitosamente.'
  end

  private #----

  def find_producto
    @producto = Producto.find(params[:id])
  end

  def find_proveedores_categorias
    @proveedores = Proveedor.order(:nombre)
    @categorias = Categoria.order(:nombre)

    if @proveedores.length == 0 || @categorias.length == 0
      redirect_to :productos, :notice => 'Verifique que exista al menos un proveedor y una categoría ingresadas en el sistema.'
    end
  end

end
