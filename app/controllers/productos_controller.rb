class ProductosController < ApplicationController

  before_filter :find_producto, :only => [:edit, :update, :destroy]
  before_filter :find_proveedores_categorias, :only => [:new, :create, :edit, :update]

  def index
    @productos = Producto.order(:nombre)
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
    @producto = Producto.find_by_id(params[:id])
  end

  def find_proveedores_categorias
    @proveedores = Proveedor.order(:nombre)
    @categorias = Categoria.order(:nombre)
  end

end
