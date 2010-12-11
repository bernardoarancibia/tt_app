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
    if params[:categoria] && params[:categoria] != ""
      @productos = Producto.includes(:categoria).where("stock_real > 0 and categoria_id = ?", params[:categoria].to_i).paginate(:per_page => 12, :page => params[:page])
    else
      @productos= Producto.includes(:categoria).where("stock_real > 0").paginate(:per_page => 12, :page => params[:page])
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

  def pedidos_clientes #------restringir acceso---------#
    @peds = Pedido.where(:cliente_id => session[:cliente_id])
    render :pedidos_clientes
  end

  def creditos_clientes #------restringir acceso---------#
    @creds = Credito.find_by_sql(["SELECT * FROM creditos, ventas where creditos.venta_id = ventas.id and ventas.tipo_venta = 1 and creditos.cliente_id = ?", session[:cliente_id]])
    render :creditos_clientes
  end

  def cierre_vs_venta #------restringir acceso---------#
    if params[:month] && params[:year]
      month = params[:month]
      year = params[:year]
    else
      month = Time.now.month
      year = Time.now.year
    end
    ventas = Venta.where("extract(month from created_at) = ? AND extract(year from created_at) = ?", month, year).order(:created_at)
    ventas_group = ventas.group_by {|venta| venta.created_at.day}

    cierres = CierreCaja.where("extract(month from created_at) = ? AND extract(year from created_at) = ?", month, year).order(:created_at)
    cierres_group = cierres.group_by {|cierre| cierre.created_at.day}

    array = []
    ventas_group.each do |key,value|
      array << { :dia => key }
      @total_v = Venta.sum(:total_venta, :conditions => ["extract(day from created_at) = ?", key ] )
      array << { :totalventa => @total_v }
      cierres_group.each do |k,v|
        if key == k
          @total_c = CierreCaja.sum(:total, :conditions => ["extract(day from created_at) = ?", k ] )
          array << { :totalcierre => @total_c }
        end
      end
    end
    @cg = cierres_group
    @vg = ventas_group
    render :cierre_venta
  end

  def prod_mas_vendidos
    @productos = Producto.all
    @detalles = Detalleventa.all
    @c3 = 0
    array_h = []
    @productos.each do |producto|
      @detalles.each do |detalle|
        @c3 += Detalleventa.sum(:cantidad, :conditions => [ "producto_id =? and id = ?",producto.id, detalle.id] )
      end
      if producto.granel?
        @c3 = @c3/1000
      end
      array_h << {:id => producto.id, :cantidad => @c3 }
      @c3 = 0
    end

    @arr = array_h.sort { |x,y| x[:cantidad] <=> y[:cantidad] }
    arr_productos = []
    nombres = []
    cantidad = []
    @arr.each do |a|
      arr_productos << { :nombre => Producto.find(a[:id]).nombre , :cantidad => a[:cantidad] }
      nombres << Producto.find(a[:id]).nombre
      cantidad << a[:cantidad]
    end

    @h = HighChart.new('graph') do |f|
      f.options[:legend][:floating] = true
      f.series(:name=>'Cantidad vendida', :data=> cantidad)
      f.options[:x_axis][:categories] = nombres
      #f.options[:chart][:defaultSeriesType] = "bar"
      f.options[:title][:text] = "Gráfico de productos v/s cantidad vendida"
      f.options[:y_axis][:title][:text] = "Cantidades"
    end
    array_clientes = []
    array_creditos = []
    clientes = Cliente.find_by_sql("select id,nombre, apellidos from clientes")

    clientes.each do |cliente|
      array_creditos << Credito.count('cliente_id', :conditions => [ "cliente_id = ?", cliente.id ])
      array_clientes << cliente.nombre + " " + cliente.apellidos
    end

    @h2 = HighChart.new('graph') do |f|
      f.options[:legend][:floating] = true
      f.series(:name=>'nº de creditos', :data=> array_creditos)
      f.x_axis(:labels =>{ :style => {:color => "black"}}, :categories => array_clientes)
      f.options[:x_axis][:labels][:rotation] = 0
      f.options[:chart][:defaultSeriesType] = "column"
      f.options[:title][:text] = "Gráfico de creditos por cliente"
      f.options[:y_axis][:title][:text] = "N° de compras con créditos"
    end


    @prods = arr_productos
    render :grafico
  end

  private #------

  def find_or_create_carrito
    session[:carrito] ||= Carrito.new
  end

end
