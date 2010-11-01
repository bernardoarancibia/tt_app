#encoding: utf-8

class ProveedoresController < ApplicationController

  before_filter :find_proveedor, :only => [:show, :edit, :update, :destroy]

  def index
    @proveedores = Proveedor.order(:nombre)
  end

  def show
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

  private #----------

  def find_proveedor
    @proveedor = Proveedor.find_by_id(params[:id])
  end
end
