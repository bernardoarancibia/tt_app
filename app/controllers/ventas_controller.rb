#encoding: utf-8
class VentasController < ApplicationController

before_filter :find_venta, :only => [:show, :edit, :update, :destroy, :anular]

  def index
    if params[:tipo_venta]
      if params[:tipo_venta] == "1"
        @ventas = Venta.where("tipo_venta = 1").order(:created_at)
      end
      if params[:tipo_venta] == "2"
        @ventas = Venta.where("tipo_venta = 2").order(:created_at)
      end
    end
    if params[:tipo_venta] == nil || params[:tipo_venta] == "0"
      @ventas = Venta.where("tipo_venta = 0").order(:created_at)
    end
  
    if params[:tipo_pago]
      if params[:tipo_pago] == "1"
        @ventas = Venta.where("tipo_pago = 1").order(:created_at)
      end
      if params[:tipo_pago] == "2"
        @ventas = Venta.where("tipo_pago = 2").order(:created_at)
      end
    end
    if params[:tipo_pago] == "0"
      @ventas = Venta.where("tipo_pago = 0").order(:created_at)
    end
  end

  def show
  end

  def new
    @venta = Venta.new
    3.times do
      detalle = @venta.detalleventas.build #array de los detalles asociados a la venta
    end
  end

  def create
    @venta = Venta.new(params[:venta])

    if @venta.save
      redirect_to @venta, :notice => "La venta se creó exitosamente."
    else
      @venta.errors.add "", "Asegurese de agregar al menos un producto"
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
    if @venta.tipo_venta == 0
      incrementar_producto @venta
    end
    @venta.destroy
    redirect_to :ventas, :notice => "La venta se eliminó exitosamente."
  end

  def anular
    venta = @venta
    venta.tipo_venta = 1
    venta.save
    incrementar_producto venta
    redirect_to :ventas, :notice => "La venta fue anulada exitosamente"
  end

  private #----------

  def find_venta
    @venta = Venta.find_by_id(params[:id])
  end

  def incrementar_producto venta
    venta.detalleventas.map do |d|
      cantidad = d.cantidad
      producto = Producto.find_by_id(d.producto_id)
      producto.stock_real += cantidad
      producto.save
    end
  end

end
