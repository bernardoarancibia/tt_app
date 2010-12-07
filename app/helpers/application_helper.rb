#encoding: utf-8

module ApplicationHelper

  def title head_title
    content_for :head do
      head_title
    end
  end

  def flash_helper
    if flash[:notice]
      content_tag :p, flash[:notice], :class => 'notice'
    end
  end

  def cantidad_producto_helper producto, cantidad
    if producto.granel?
      "#{cantidad} gramos"
    else
      "#{cantidad} unidades"
    end
  end

  def stock_real_helper producto
    if producto.granel?
      "#{number_with_delimiter producto.stock_real.to_f/1000} Kg"
    else
      "#{producto.stock_real} unidades"
    end
  end

  def stock_critico_helper producto
    if producto.granel?
      "#{number_with_delimiter producto.stock_critico.to_f/1000} Kg"
    else
      "#{producto.stock_critico} unidades"
    end
  end

  def link_to_remove_fields(name, f)
    #observe_field
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end


  def link_to_add_fields(name, f, association)
  new_object = f.object.class.reflect_on_association(association).klass.new
  fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
    render(association.to_s.singularize + "_fields", :f => builder)
  end
  link_to_function(name,("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"))
  end

  def mostrar_nombre_tipo_pago tipo
    case tipo
    when 0
      tipo_nombre = "efectivo"
    when 1
      tipo_nombre = "crédito"
    when 2
      tipo_nombre = "tarjeta de débito"
    else
      tipo_nombre = "tipo desconocido"
    end
  end

  def mostrar_interes_entero decimal
      entero = (decimal * 100) -100
  end

  def tmp_to_hour tmp
    tmp.strftime(fmt='%H:%M')
  end

  def tmp_to_date tmp
    tmp.strftime(fmt='%d/%m/%Y')
  end
    
  def mostrar_tipo_merma tipo_merma
    case tipo_merma
      when 0
        tipo_nombre = "fecha de vencimiento"
      when 1
        tipo_nombre = "producto dañado"
      when 2
        tipo_nombre = "autoconsumo"
      else
        tipo_nombre = "otra razón"
      end
  end
 
end



