# encoding: utf-8

class ProductosController < ApplicationController

  # sesiones, cache y páginas privadas
  before_filter :es_administrador?
  before_filter :administrador_pages, :only =>  [:edit, :new, :create, :destroy]

  # acceso a la base de datos común
  before_filter :find_producto, :only => [:edit, :update, :destroy]
  before_filter :find_proveedores_categorias, :only => [:new, :create, :edit, :update]

  def index
    if params[:categoria]
      @productos = Producto.where(["categoria_id = ?", params[:categoria]]).order(:nombre)
    elsif params[:proveedor]
      @productos = Producto.where(["proveedor_id = ?", params[:proveedor]]).order(:nombre)
    elsif params[:granel] == "true"
      @productos = Producto.where("granel = true").order(:nombre)
    elsif params[:granel] == "false"
      @productos = Producto.where("granel = false").order(:nombre)
    elsif params[:orden] == "stock_critico"
      @productos = Producto.order(:stock_critico)
    elsif params[:orden] == "stock_real"
      @productos = Producto.order(:stock_real)
    elsif params[:orden] == "nombre"
      @productos = Producto.order(:nombre)
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
    if @producto.detalleventas.count == 0 && @producto.detallepedidos.count == 0
      @producto.destroy
      redirect_to :productos, :notice => 'El producto fue eliminado exitosamente.'
    else
      redirect_to :productos, :notice => 'No se puede eliminar un producto asociado a una venta o pedido'
    end
  end

  def buscar
    nombre = params[:buscar].downcase
    @producto =  Producto.find_by_nombre(nombre)
    if @producto.nil?
      redirect_to :productos, :notice => 'No se encontró el producto buscado'
    else
      redirect_to @producto
    end
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
