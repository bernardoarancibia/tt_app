class Carrito

  attr_reader :items
  attr_reader :total_carrito

  def initialize
    @items = []
    @total_carrito = 0
  end

  def add_item producto
    @items << DetalleCarrito.new_based_on(producto)
    @total_carrito += producto.precio_unitario
  end

  def remove_item producto
    @items.delete(@items.find {|item| item.producto.id == producto.id})
    @total_carrito -= producto.precio_unitario
  end

  def update_items cantidad
    i = 0
    @items.each do |item|
      item.cantidad = cantidad[i]
      i += 1
    end
  end

end
