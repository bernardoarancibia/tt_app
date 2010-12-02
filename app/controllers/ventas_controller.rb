#encoding: utf-8
class VentasController < ApplicationController

  before_filter :vendedor_pages

  before_filter :find_venta, :only => [:show, :edit, :update, :destroy, :anular, :pagar_credito]

  def index
    if params[:tipo_venta]
      if params[:tipo_venta] == "1"
        @ventas = Venta.where("tipo_venta = 1").order(:created_at)
      end
    end
    if params[:tipo_venta] == nil || params[:tipo_venta] != "1"
      @ventas = Venta.where("tipo_venta = 0 and tipo_pago <> 1").order("created_at desc")
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
    @clientes = Cliente.all
    redirect_to :ventas, :notice => "No hay productos disponibles para la venta" if @productos.length == 0
    @venta.build_credito
    @venta.detalleventas.build
  end

  def create
    @productos = Producto.all
    @clientes = Cliente.all
    @venta = Venta.new(params[:venta])
    @venta.vendedor_id = session[:vendedor_id]
    if params[:add_detalle]
      @venta.build_credito
      @venta.detalleventas.build
      elsif params[:remove_detalle]
    else
      #if @venta.tipo_pago == 1
        if @venta.save
          flash[:notice] = "La venta se creó exitosamente"
          #redirect_to @venta, :notice => "La venta se creó exitosamente."
          redirect_to @venta and return
        else
        @venta.errors.add "", "Asegurese de agregar al menos un producto"
        #render :new
        end
      #end
    end
    render :action => 'new'
  end

  def edit
    if @venta.tipo_venta == 1
      @venta.build_credito
    end
    @productos = Producto.all
    @clientes = Cliente.all
    @venta.detalleventas.map do |d|
      d.nombre_de_producto = Producto.find_by_id(d.producto_id).nombre
    end
    if @venta.tipo_venta == 1
      d.nombre_de_cliente = Cliente.find_by_id(d.cliente_id).apellidos
    end
    #@venta.detalleventas.build
  end

  def update
    @productos = Producto.all
    @clientes = Cliente.all

    if params[:add_detalle]
      @venta.detalleventas.map do |d|
        d.nombre_de_producto = Producto.find_by_id(d.producto_id).nombre
      end
      if @venta.tipo_venta == 1
          d.nombre_de_cliente = Cliente.find_by_id(d.cliente_id).apellidos
      end
      unless params[:venta][:detalleventas_attributes].blank?
        for attribute in params[:venta][:detalleventas_attributes]
          @venta.detalleventas.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
        end
      end
      if @venta.tipo_venta == 1
        @venta.build_credito
      end
      @venta.detalleventas.build
    elsif params[:remove_detalle]
      removed_detalleventas = params[:venta][:detalleventas_attributes].collect { |i, att| att[:id] if (att[:id] && att[:_destroy].to_i == 1) }
      ajustar_stock removed_detalleventas
      Detalleventa.delete(removed_detalleventas)
      @venta.calcular_total_venta
      @venta.save
      flash[:notice] = "Detalle(s) Borrados"
      @venta.detalleventas.map do |d|
        d.nombre_de_producto = Producto.find_by_id(d.producto_id).nombre
      end
      if @venta.tipo_venta == 1
          d.nombre_de_cliente = Cliente.find_by_id(d.cliente_id).apellidos
      end
      for attribute in params[:venta][:detalleventas_attributes]
        @venta.detalleventas.build(attribute.last.except(:_destroy)) if (!attribute.last.has_key?(:id) && attribute.last[:_destroy].to_i == 0)
      end
    else
      if @venta.update_attributes(params[:venta])
      flash[:notice] = "La venta se actualizó existosamente."
      redirect_to @venta and return
      #redirect_to @venta, :notice => "La venta se actualizó exitosamente."
      else
        @venta.errors.add "", "Asegurese de agregar al menos un producto"
      end
    end
    render :action => 'edit'
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

  def ajustar_stock id
      id.each do |d|
        if d != nil
        detalle = Detalleventa.find(d.to_i)
        producto = Producto.find(detalle.producto_id)
        producto.stock_real += detalle.cantidad
        producto.save
        end
      end
  end

  def pagar_credito
    venta = @venta
    venta.tipo_pago = 0
    venta.save
    redirect_to :ventas, :notice => "La venta a crédito fue pagada exitosamente"
  end

  def aceptar_pedido
    @productos = Producto.all
    @clientes = Cliente.all

    @venta = Venta.new
    @venta.vendedor_id = session[:vendedor_id]

    pedido = Pedido.find(params[:id])
    detalles = Detallepedido.where(:pedido_id => pedido.id)

    detalles.each do |detalle|
      detalle_venta = @venta.detalleventas.build
      # aquí llenar los detalles de venta
      # OJO con nombre_de_producto
      detalle_venta.nombre_de_producto = Producto.find(detalle.producto_id).nombre
      detalle_venta.cantidad = detalle.cantidad
    end


    @venta.build_credito
    render :action => "ventas/new"
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
