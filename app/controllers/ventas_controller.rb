#encoding: utf-8
class VentasController < ApplicationController

  before_filter :vendedor_pages

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
    if params[:tipo_venta] == nil || params[:tipo_venta] != "1" && params[:tipo_venta] != "2"
      @ventas = Venta.where("tipo_venta = 0 and tipo_pago <> 1").order(:created_at)
    end

    if params[:tipo_pago]
      if params[:tipo_pago] == "1"
        @ventas = Venta.where("tipo_pago = 1 and tipo_venta <> 1").order(:created_at)
      end
      if params[:tipo_pago] == "2"
        @ventas = Venta.where("tipo_pago = 2 and tipo_venta <> 1").order(:created_at)
      end
    end
    if params[:tipo_pago] == "0"
      @ventas = Venta.where("tipo_pago = 0 and tipo_venta <> 1").order(:created_at)
    end

    if params[:vendedor]
      @ventas = Venta.where("vendedor_id = ?", params[:vendedor]).order(:created_at)
    end
 
  end

  def show
  end

  def new
    @venta = Venta.new
    @productos = Producto.all
    redirect_to :ventas, :notice => "No hay productos disponibles para la venta" if @productos.length == 0
    #5.times do
    #  detalle = @venta.detalleventas.build #array de los detalles asociados a la venta
    #end
    @venta.build_credito
  end

  def create
    @productos = Producto.all
    @venta = Venta.new(params[:venta])
    @venta.vendedor_id = session[:vendedor_id]

    if @venta.save
      redirect_to @venta, :notice => "La venta se creó exitosamente."
    else
      @venta.errors.add "", "Asegurese de agregar al menos un producto"
      render :new
    end
  end

  def edit
    @productos = Producto.all
    @venta.detalleventas.map do |d|
      d.nombre_de_producto = Producto.find_by_id(d.producto_id).nombre
    end
  end

  def update
   # @venta.detalleventas.each do |d|
   #   if d.producto.nombre != params[:nombre_de_producto]
   #     incremento_update d
   #   end
   # end
    if @venta.update_attributes(params[:venta])
      redirect_to @venta, :notice => "La venta se actualizó exitosamente."
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

  def buscar_boleta
    @venta = Venta.find_by_numero_boleta(params[:buscar])
    if @venta.nil?
      redirect_to :ventas, :notice => "No se encontró la venta buscada por ese numero de boleta"
    else
      redirect_to @venta
    end  
  end

  private #----------

  def find_venta
    @venta = Venta.find(params[:id])
  end

  def incrementar_producto venta
    venta.detalleventas.map do |d|
      cantidad = d.cantidad
      producto = Producto.find(d.producto_id)
      producto.stock_real += cantidad
      producto.save
    end
  end

  def incremento_update detalle
    detalle.producto.stock_real += detalle.cantidad
    detalle.producto.save
  end

end
