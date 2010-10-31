#encoding: utf-8
class VendedoresController < ApplicationController

before_filter :find_vendedor, :only => [:show, :edit, :update, :destroy]

  def index
    @vendedores = Vendedor.order(:rut)
  end

  def list
  end

  def new
    @vendedor = Vendedor.new
  end

  def create
    @vendedor = Vendedor.new(params[:vendedor])
    if @vendedor.save
      redirect_to :vendedores, :notice => 'El Vendedor se ha creado exitosamente'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @vendedor.update_attributes(params[:vendedor])
      redirect_to :vendedores, :notice => 'El Vendedor se ha modificado exitosamente'
    else
      render :edit
    end
  end

  def destroy
    # if vendedor no tiene ventas/pedidos asociados
      @vendedor.destroy
      redirect_to :vendedores, :notice => "El Vendedor fue eliminado exitosamente."
    # else
    #  redirect_to :vendedores,
    #    :notice => "No se pudo borrar el vendedor, ya que posee ventas/pedidos asociados."
    
  end


  protected #------------------

  def find_vendedor
    @vendedor = Vendedor.find_by_id(params[:id])
  end


end
