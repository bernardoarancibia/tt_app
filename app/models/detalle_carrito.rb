class DetalleCarrito
  attr_accessor :producto, :cantidad, :total_detalle

  def self.new_based_on producto
    detalle_carrito = self.new
    detalle_carrito.producto = producto
    detalle_carrito.cantidad = 1
    detalle_carrito.total_detalle = producto.precio_unitario
    return detalle_carrito
  end

end
