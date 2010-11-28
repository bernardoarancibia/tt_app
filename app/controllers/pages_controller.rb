#encoding: utf-8

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
              redirect_to :home, :notice => "Bienvenido #{vendedor.nombre}, aquí puedes revisar tus tareas para hoy."
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
    redirect_to :home, :notice => 'Se ha desconectado del sistema'
  end

end
