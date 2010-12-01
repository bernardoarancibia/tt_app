class Carrito

  attr_reader :items
  attr_reader :total_carrito
  attr_accessor :comentario

  def initialize
    @items = []
    @total_carrito = 0
    @comentario = nil
  end

  def add_item producto
    item = DetalleCarrito.new_based_on(producto)
    @items << item
    @total_carrito += item.total_detalle #* item.cantidad
  end

  def remove_item producto
    item = @items.find { |item| item.producto.id == producto.id }
    @total_carrito -= item.total_detalle
    @items.delete(item)
    @total_carrito = 0 if @items.empty?
  end

  def update_items cantidad
    i = 0
    @total_carrito = 0
    @items.each do |item|
      item.cantidad = cantidad[i].to_i
      if item.producto.granel?
        item.total_detalle = (item.producto.precio_unitario * item.cantidad) / 1000
      else
        item.total_detalle = item.cantidad * item.producto.precio_unitario
      end
      @total_carrito += item.total_detalle
      i += 1
    end
  end

  def enviar session_cliente
    #se crea el pedido en la bd
    pedido = Pedido.new
    pedido.cliente_id = session_cliente
    pedido.total_pedido = @total_carrito #self.total_carrito
    pedido.comentario = @comentario #self.comentario
    pedido.save
    @items.each do |item|
      #aqui se llenan los detalepedido en la bd
      detalle_pedido = Detallepedido.new
      detalle_pedido.pedido = pedido
      detalle_pedido.producto_id = item.producto.id
      detalle_pedido.cantidad = item.cantidad
      detalle_pedido.total_detalle = item.total_detalle
      detalle_pedido.save
    end
  end

  def destroy
    @items = []
    @total_carrito = 0
  end

end
