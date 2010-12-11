#encoding: utf-8
class ClientesController < ApplicationController

before_filter :find_cliente, :only => [:show, :edit, :update,:update_perfil, :destroy]

  def index
    if params[:cliente]
      @clientes = Cliente.where("id = ?",params[:cliente])
    else
      @clientes = Cliente.order(:rut).paginate(:per_page => 10, :page => params[:page])
    end
  end

  def show
    @cliente.password_confirma = @cliente.password
  end

  def new
    @cliente = Cliente.new
  end

  def create
    @cliente = Cliente.new(params[:cliente])
    if @cliente.save
      redirect_to :clientes, :notice => 'El Cliente se ha creado exitosamente'
    else
      render :new
    end
  end

  def edit
    @cliente.password_confirma = @cliente.password
  end

  def update_perfil
    if @cliente.update_attributes(params[:cliente])
      redirect_to :home, :notice => 'Su perfil se ha modificado exitosamente'
    else
      render :show
    end
  end

  def update
    if @cliente.update_attributes(params[:cliente])
      redirect_to :clientes, :notice => 'El cliente se ha modificado exitosamente'
    else
      render :edit
    end
  end

  def destroy
    if @cliente.pedidos.length == 0 && @cliente.creditos.length == 0
      @cliente.destroy
      redirect_to :clientes, :notice => "El Cliente fue eliminado exitosamente."
    else
      redirect_to :clientes,
      :notice => "No se pudo borrar el cliente, ya que posee pedidos o creditos asociados."
    end
  end

  def buscar
    apellidos = params[:buscar]
    @cliente =  Cliente.find_by_apellidos(apellidos)
    if @cliente.nil?
      redirect_to :clientes, :notice => 'No se encontró el cliente buscado'
    else
      redirect_to :controller => :clientes, :cliente => @cliente.id
    end
  end

  protected #------------------

  def find_cliente
    @cliente = Cliente.find_by_id(params[:id])
  end

end
