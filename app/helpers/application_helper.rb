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

end
