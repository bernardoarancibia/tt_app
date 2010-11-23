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
    @proveedor.destroy
    redirect_to :proveedores, :notice => "El proveedor se eliminó exitosamente."
  end

  def buscar
    nombre = params[:buscar].downcase
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
