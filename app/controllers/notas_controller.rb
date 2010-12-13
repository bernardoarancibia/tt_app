#encoding: utf-8
class NotasController < ApplicationController

  before_filter :vendedor_pages

  before_filter :find_notas, :only => [:show, :edit, :update, :destroy]

  def index
    if params[:vendedor_id]
      @notas = Nota.where(:vendedor_id => params[:vendedor_id]).includes(:vendedor).order("updated_at desc").paginate(:per_page => 6, :page => params[:page])
    else
      @notas = Nota.order("updated_at desc").includes(:vendedor).paginate(:per_page => 6, :page => params[:page])
    end
  end

  def show
  end

  def new
    @nota = Nota.new
  end

  def create
    @nota = Nota.new(params[:nota])
    @nota.vendedor_id = session[:vendedor_id]
    if @nota.save
      redirect_to :notas, :notice => 'Se ha ingresado la nota correctamente'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @nota.update_attributes(params[:nota])
      redirect_to :notas, :notice => 'Se ha modificado la nota correctamente'
    else
      render :edit
    end
  end

  def destroy
      @nota.destroy
      redirect_to :notas, :notice => 'Se ha eliminado la nota correctamente'
  end

  def vendedores
    @notas = Notas.find(:all, :conditions => ["vendedor_id = ?", params[:id]])
    redirect_to :controller => :notas, :action => :index
  end

  private #-------------

  def find_notas
    @nota = Nota.find_by_id(params[:id])
  end

end

