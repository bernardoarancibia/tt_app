#encoding: utf-8
class VendedoresController < ApplicationController

  before_filter :vendedor_pages
  before_filter :administrador_pages, :only => [:new, :create, :edit, :destroy]
  before_filter :find_vendedor, :only => [:show, :edit, :update,:update_perfil, :destroy]

  def index
    if params[:vendedor]
      @vendedores = Vendedor.where("id = ?",params[:vendedor]).paginate(:per_page => 10, :page => params[:page])
    elsif params[:activo]
      @vendedores = Vendedor.where("activo = ?",params[:activo]).paginate(:per_page => 10, :page => params[:page])
    else
      @vendedores = Vendedor.order(:rut).paginate(:per_page => 10, :page => params[:page])
    end
  end

  def list
  end

  def show
    @vendedor.password_confirma = @vendedor.password
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
    @vendedor.password_confirma = @vendedor.password
  end

  def update_perfil
    if @vendedor.update_attributes(params[:vendedor])
      redirect_to :home, :notice => 'Su perfil se ha modificado exitosamente'
    else
      render :show
    end
  end

  def update
    if @vendedor.update_attributes(params[:vendedor])
      redirect_to :vendedores, :notice => 'El Vendedor se ha modificado exitosamente'
    else
      render :edit
    end
  end

  def destroy
    if @vendedor.ventas.length == 0 && @vendedor.pedidos.length == 0
      @vendedor.destroy
      redirect_to :vendedores, :notice => "El Vendedor fue eliminado exitosamente."
    else
      redirect_to :vendedores,
      :notice => "No se pudo borrar el vendedor, ya que posee ventas/pedidos asociados."
    end
  end

  def buscar
    apellidos = params[:buscar]
    @vendedor =  Vendedor.find_by_apellidos(apellidos)
    if @vendedor.nil?
      redirect_to :vendedores, :notice => 'No se encontró el vendedor buscado'
    else
      redirect_to :controller => :vendedores, :vendedor => @vendedor.id
    end
  end

  protected #------------------

  def find_vendedor
    @vendedor = Vendedor.find_by_id(params[:id])
  end


end
