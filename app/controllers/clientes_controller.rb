#encoding: utf-8
class ClientesController < ApplicationController

before_filter :find_cliente, :only => [:show, :edit, :update, :destroy]

  def index
    @clientes = Cliente.order(:rut)
  end

  def list
  end

  def show
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
  end

  def update
    if @cliente.update_attributes(params[:cliente])
      redirect_to :clientes, :notice => 'El Cliente se ha modificado exitosamente'
    else
      render :edit
    end
  end

  def destroy
    # if cliente tiene pedidos
      @cliente.destroy
      redirect_to :clientes, :notice => "El Cliente fue eliminado exitosamente."
    # else
    #  redirect_to :proveedores,
    #    :notice => "No se pudo borrar el cliente, ya que posee pedidos asociados."
    
  end


  protected #------------------

  def find_cliente
    @cliente = Cliente.find_by_id(params[:id])
  end

end
