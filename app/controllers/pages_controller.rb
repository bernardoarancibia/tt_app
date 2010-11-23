class PagesController < ApplicationController

  def index
  end

  def about
  end

  # login de clientes
  def login_clientes
    render "login"
  end

  def login_ventas
    render "login"
  end

end
