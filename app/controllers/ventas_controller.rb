#encoding: utf-8
class VentasController < ApplicationController

  before_filter :vendedor_pages

  before_filter :find_venta, :only => [:show, :edit, :update, :destroy, :anular, :pagar_credito]

  def index
    paginas = 10
    @fecha_inicio_ventas = Venta.minimum(:created_at).year if Venta.count >0
    month = Time.now.month
    year = Time.now.year
    day = Time.now.day
    if params[:tipo_venta] == "1"
        @ventas = Venta.where("tipo_venta = 1").order("created_at desc").paginate(:per_page => paginas, :page => params[:page])
    elsif params[:tipo_venta] == "0"
        @ventas = Venta.where("tipo_venta = 0").order("created_at desc").paginate(:per_page => paginas, :page => params[:page])
    elsif params[:tipo_pago] == "1"
        @ventas = Venta.where("tipo_pago = 1 and tipo_venta <> 1").order("created_at desc").paginate(:per_page => paginas, :page => params[:page])
    elsif params[:tipo_pago] == "2"
        @ventas = Venta.where("tipo_pago = 2 and tipo_venta <> 1").order("created_at desc").paginate(:per_page => paginas, :page => params[:page])
    elsif params[:tipo_pago] == "0"
      @ventas = Venta.where("tipo_pago = 0 and tipo_venta <> 1").order("created_at desc").paginate(:per_page => paginas, :page => params[:page])
    elsif params[:vendedor_id]
      @ventas = Venta.where(:vendedor_id => params[:vendedor_id]).order("created_at desc").paginate(:per_page => paginas, :page => params[:page])
    elsif params[:month] && params[:year] && params[:day]
      month = params[:month]
      year = params[:year]
      day = params[:day]
      @ventas = Venta.where("extract(month from created_at) = ? AND extract(year from created_at) = ? AND extract(day from created_at) = ?", month, year, day).order("created_at desc").paginate(:per_page => paginas, :page => params[:page])
    else
      @ventas = Venta.where("extract(month from created_at) = ? AND extract(year from created_at) = ? AND extract(day from created_at) = ? AND tipo_venta = 0", month, year, day).order("created_at desc").paginate(:per_page => paginas, :page => params[:page])
    end

  end

  def show
  end


  def new
    @venta = Venta.new
    @venta.numero_boleta = Venta.maximum(:numero_boleta).next if Venta.maximum(:numero_boleta)
    @productos = Producto.all
    @clientes = Cliente.all
    redirect_to :ventas, :notice => "No hay productos disponibles para la venta" if @productos.length == 0
    @venta.detalleventas.build
    @venta.build_credito
    fecha_pago = Time.now + 1.month
    @venta.credito.fecha_pago = fecha_pago.strftime("%d/%m/%Y")
  end

  def create
    @productos = Producto.all
    @clientes = Cliente.all
    @venta = Venta.new(params[:venta])
    @venta.vendedor_id = session[:vendedor_id]

    if params[:tipo_pago] == 1
      @venta.build_credito
    end

    if params[:add_detalle]
      @venta.build_credito unless @venta.credito
      @venta.detalleventas.build
    elsif params[:remove_detalle]
      @venta.build_credito unless @venta.credito
    else
      @venta.pedido_id = session[:pedido_id] if session[:pedido_id]
      if @venta.save
        #decrementar_producto @venta
        session[:pedido_id] = nil
        flash[:notice] = "La venta se creó exitosamente"
        redirect_to @venta and return
      else
        @venta.errors.add "", "Asegurese de agregar al menos un producto"
        @venta.build_credito unless @venta.credito
      end
    end
    render :action => 'new'
  end

  def edit
    @productos = Producto.all
    @clientes = Cliente.all
    @venta.detalleventas.map do |d|
      d.nombre_de_producto = Producto.find_by_id(d.producto_id).nombre
    end
    @venta.build_credito unless @venta.credito
  end

  def update
    @productos = Producto.all
    @clientes = Cliente.all

    #@venta.build_credito unless @venta.tipo_pago == 1
    if params[:add_detalle]
      @venta.detalleventas.map do |d|
        d.nombre_de_producto = Producto.find_by_id(d.producto_id).nombre
      end
      unless params[:venta][:detalleventas_attributes].blank?
        for attribute in params[:venta][:detalleventas_attributes]
          @venta.detalleventas.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
        end
      end
      @venta.build_credito unless @venta.credito
      @venta.detalleventas.build
    elsif params[:remove_detalle]
      removed_detalleventas = params[:venta][:detalleventas_attributes].collect { |i, att| att[:id] if (att[:id] && att[:_destroy].to_i == 1) }
      ajustar_stock removed_detalleventas
      Detalleventa.delete(removed_detalleventas)
      @venta.calcular_total_venta
      @venta.save
      @venta.build_credito unless @venta.credito
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
        @venta.build_credito unless @venta.credito
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

  def ajustar_stock_decre id
    id.each do |d|
      if d != nil
        detalle = Detalleventa.find(d.to_i)
        producto = Producto.find(detalle.producto_id)
        producto.stock_real -= detalle.cantidad
        producto.save
      end
    end
  end

  def pagar_credito
    venta = @venta
    venta.tipo_pago = 0
    venta.save
    credito = Credito.find_by_venta_id(venta.id)
    credito.total_creditos = credito.total_con_interes
    credito.save
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
      detalle_venta.nombre_de_producto = Producto.find(detalle.producto_id).nombre
      detalle_venta.cantidad = detalle.cantidad
    end
    @venta.build_credito
    session[:pedido_id] = pedido.id
    render :action => "ventas/new"
  end

  def libro_ventas
    if params[:month] && params[:year]
      month = params[:month]
      year = params[:year]
    else
      month = Time.now.month
      year = Time.now.year
    end
    @ventas = Venta.find_libro_ventas(month, year)
    @mermas = Merma.find_por_fecha(month, year)
    Venta.all.any? ? @fecha_inicio_ventas = Venta.minimum(:created_at).year : @fecha_inicio_ventas = Time.now.year
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

  def decrementar_producto venta
    venta.detalleventas.map do |d|
      cantidad = d.cantidad
      producto = Producto.find(d.producto_id)
      producto.stock_real -= cantidad
      producto.save
    end
  end

  def incremento_update detalle
    detalle.producto.stock_real += detalle.cantidad
    detalle.producto.save
  end
end
