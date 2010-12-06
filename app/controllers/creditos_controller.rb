#encoding: utf-8
class CreditosController < ApplicationController

  def index
    @clientes = Cliente.all
    if params[:cliente_id]
      @creditos = Credito.where(:cliente_id => params[:cliente_id]).order(:created_at)
    else
      @creditos = Credito.order(:created_at)
    end
  end

  def buscar
    apellido = params[:buscar]
    @cliente =  Cliente.find_by_apellidos(apellido)
    if @cliente.nil?
      redirect_to :creditos, :notice => 'No se encontró la merma buscada'
    else
      redirect_to :controller => :creditos, :cliente => @cliente.id
    end
  end


end
