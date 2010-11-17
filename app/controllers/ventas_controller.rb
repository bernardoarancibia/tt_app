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
    llenar_detalle(params[:producto], params[:cantidad])
    @venta = Venta.new(params[:venta])

    render :new
    if @venta.save
      redirect_to :ventas, :notice => "La venta se creó exitosamente."
    else
      render :new
    end

    #manejo de detalleventas
    #decremento de stock de producto(con validaciones)
    #antes de guardar la venta (calcular total_venta)
    #
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

end
