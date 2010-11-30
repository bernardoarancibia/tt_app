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

end
