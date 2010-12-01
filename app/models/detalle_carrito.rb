class DetalleCarrito
  attr_accessor :producto, :cantidad, :total_detalle

  def self.new_based_on producto
    detalle_carrito = self.new
    detalle_carrito.producto = producto
    if producto.granel?
      detalle_carrito.cantidad = 250
      detalle_carrito.total_detalle = (producto.precio_unitario * detalle_carrito.cantidad) / 1000
    else
      detalle_carrito.cantidad = 1
      detalle_carrito.total_detalle = producto.precio_unitario * detalle_carrito.cantidad
    end
    return detalle_carrito
  end

end
