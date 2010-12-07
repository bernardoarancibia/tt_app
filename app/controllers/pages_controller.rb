#encoding: utf-8

class PagesController < ApplicationController

  def index
  end

  def about
  end

  # login de clientes
  def login_clientes

    if session[:vendedor_id] || session[:cliente_id]
      redirect_to :home, :notice => "Usted ya se encuentra con una sesión activa."
    else
      if params[:usuario] || params[:password]
        if params[:usuario] != "" && params[:password] != ""
          rut, dv = params[:usuario].split("-")
          cliente = Cliente.where("rut = ? and dv = ?", rut.to_i, dv.to_s).first
          if cliente
            if cliente.password == params[:password] && cliente.activo?
              session[:cliente_id] = cliente.id
              redirect_to :home, :notice => "Bienvenido #{cliente.nombre}, ingresa a nuestro catálogo para enviarnos tu pedido."
            else
              redirect_to :login_clientes, :notice => "Login incorrecto"
            end
          else
            redirect_to :login_clientes, :notice => "Login incorrecto"
          end
        else
          redirect_to :login_clientes, :notice => "Login incorrecto"
        end
      else
        render "login"
      end
    end

  end

  def login_ventas

    if session[:vendedor_id] || session[:cliente_id]
      redirect_to :home, :notice => "Usted ya se encuentra con una sesión activa."
    else
      if params[:usuario] || params[:password]
        if params[:usuario] != "" && params[:password] != ""
          rut, dv = params[:usuario].split("-")
          vendedor = Vendedor.where("rut = ? and dv = ?", rut.to_i, dv.to_s).first
          if vendedor
            if vendedor.password == params[:password]
              session[:vendedor_id] = vendedor.id
              redirect_to :ventas, :notice => "Bienvenido #{vendedor.nombre}, aquí puedes revisar tus tareas para hoy."
            else
              redirect_to :login_ventas, :notice => "Login incorrecto"
            end
          else
            redirect_to :login_ventas, :notice => "Login incorrecto"
          end
        else
          redirect_to :login_ventas, :notice => "Login incorrecto"
        end
      else
        render "login"
      end
    end

  end

  def logout
    session[:vendedor_id] = nil
    session[:cliente_id] = nil
    # Modificar si se desea mantener el pedido luego de logout
    session[:carrito] = nil
    redirect_to :home, :notice => 'Se ha desconectado del sistema.'
  end

  def catalogo
    @categorias = Categoria.order(:nombre)
    if params[:categoria]
      @productos = Producto.includes(:categoria).where("stock_real > 0 and categoria_id = ?", params[:categoria].to_i)
    else
      @productos = Producto.includes(:categoria).where("stock_real > 0")
    end
  end

  def add_to_carrito
    producto = Producto.find(params[:id])
    @carrito = find_or_create_carrito
    if @carrito.items.find {|item| item.producto.id == producto.id}
      redirect_to :carrito, :notice => "El producto ya se encuentra en su pedido. Modifique su cantidad si así lo desea."
    else
      @carrito.add_item(producto)
      redirect_to :carrito
    end
  end

  def remove_from_carrito
    producto = Producto.find(params[:id])
    @carrito = find_or_create_carrito
    @carrito.remove_item(producto)
    redirect_to :carrito, :notice => "El producto fue eliminado del carrito de pedidos."
  end

  def carrito
    @carrito = find_or_create_carrito
  end

  def empty_carrito
    session[:carrito] = nil
    redirect_to :carrito, :notice => "Los productos del carrito fueron eliminados del pedido."
  end

  def update_carrito
    @carrito = find_or_create_carrito
    cantidad = params[:cantidad]
    @carrito.update_items(cantidad)
    redirect_to :carrito, :notice => "Se actualizó la cantidad de productos en su pedido."
  end

  def enviar_pedido
    @carrito = find_or_create_carrito
    @carrito.comentario = params[:comentario]
    if @carrito.total_carrito == 0
      redirect_to :carrito, :notice => "Agregue al menos un producto al pedido."
    else
      # tomar los datos de carrito y enviarlos a las tablas pedido y detalle pedido
      @carrito.enviar(session[:cliente_id])
      @carrito.destroy
      redirect_to :home, :notice => "Su pedido ya ha sido envíado a nuestros vendedores, debe esperar a que éstos lo reciban."
    end
  end

  private #------

  def find_or_create_carrito
    session[:carrito] ||= Carrito.new
  end

end
