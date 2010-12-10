#encoding: utf-8

class ProveedoresController < ApplicationController

  before_filter :find_proveedor, :only => [:show, :edit, :update, :destroy]

  def index
    @proveedores = Proveedor.order(:nombre)
  end

  def show
    @productos = @proveedor.productos.count
  end

  def new
    @proveedor = Proveedor.new
  end

  def create
    @proveedor = Proveedor.new(params[:proveedor])
    if @proveedor.save
      redirect_to :proveedores, :notice => "El proveedor se creó exitosamente."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @proveedor.update_attributes(params[:proveedor])
      redirect_to :proveedores, :notice => "El proveedor se actualizó exitosamente."
    else
      render :edit
    end
  end

  def destroy
    if @proveedor.productos.count == 0
      @proveedor.destroy
      redirect_to :proveedores, :notice => "El proveedor se eliminó exitosamente."
    else
      redirect_to :proveedores, :notice => 'El proveedor no pudo ser eliminado, ya que posee productos asociados'
    end
  end

  def buscar
    nombre = params[:buscar]
    @proveedor =  Proveedor.find_by_nombre(nombre)
    if @proveedor.nil?
      redirect_to :proveedores, :notice => 'No se encontró el proveedor buscado'
    else
      redirect_to @proveedor
    end
  end

  private #----------

  def find_proveedor
    @proveedor = Proveedor.find(params[:id])
  end
end
