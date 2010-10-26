#encoding: utf-8
class CategoriasController < ApplicationController
  
  def index
    @categorias = Categoria.order(:nombre)
  end

  def list
  end  

  def new
    @categoria = Categoria.new  
  end

  def create
    @categoria = Categoria
  end

  def edit
     
  end

  def update
    
  end  

  def destroy
  
  end

  def productos

  end

end
