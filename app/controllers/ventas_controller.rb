#encoding: utf-8
class VentasController < ApplicationController

before_filter :find_venta, :only => [:show, :edit, :update, :destroy]

  def index
    @ventas = Venta.order(:created_at)
  end

  def show
  end

  def new
    @venta = Venta.new
  end

  def create
    #manejo de detalleventas
    llenar_detalle(params[:producto], params[:cantidad])
    @venta = Venta.new(params[:venta])

    render :new


    #decremento de stock de producto(con validaciones)
    #antes de guardar la venta (calcular total_venta)
    #
    #if @venta.save
    #  redirect_to :ventas, :notice => "La venta se creó exitosamente."
    #else
    #  render :new
    #end
  end

  def edit
  end

  def update
    if @venta.update_attributes(params[:venta])
      redirect_to :ventas, :notice => "La venta se actualizó exitosamente."
    else
      render :edit
    end
  end

  def destroy
    @venta.destroy
    redirect_to :ventas, :notice => "La venta se eliminó exitosamente."
  end

  private #----------

  def find_venta
    @venta = Venta.find_by_id(params[:id])
  end

  def llenar_detalle producto, cantidad
    @detalle = []
    j=0
    producto.each do |nombre|
      # un array de detalles
      @detalle[j] = Detalleventa.new
      @detalle[j].producto_id = Producto.where(["nombre = ?", nombre])
      j+=1
    end
  end

end
