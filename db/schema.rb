# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101116162725) do

  create_table "categorias", :force => true do |t|
    t.string "nombre", :limit => 40, :null => false
  end

  create_table "cierres_cajas", :force => true do |t|
    t.integer  "vendedor_id", :null => false
    t.integer  "total",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clientes", :force => true do |t|
    t.integer  "rut",                                        :null => false
    t.string   "dv",         :limit => 1,                    :null => false
    t.string   "password",   :limit => 15,                   :null => false
    t.boolean  "activo",                   :default => true
    t.string   "nombre",     :limit => 40,                   :null => false
    t.string   "apellidos",  :limit => 40,                   :null => false
    t.string   "direccion"
    t.integer  "cod_fono",   :limit => 2
    t.integer  "num_fono"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "detallepedidos", :force => true do |t|
    t.integer  "pedido_id",        :null => false
    t.integer  "producto_id",      :null => false
    t.integer  "precio_historico", :null => false
    t.integer  "cantidad",         :null => false
    t.integer  "total_detalle",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "detalleventas", :force => true do |t|
    t.integer  "venta_id",         :null => false
    t.integer  "producto_id",      :null => false
    t.integer  "precio_historico", :null => false
    t.integer  "cantidad",         :null => false
    t.integer  "total_detalle",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mermas", :force => true do |t|
    t.integer  "producto_id",              :null => false
    t.integer  "cantidad",                 :null => false
    t.integer  "tipo_merma",  :limit => 2, :null => false
    t.text     "comentario"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notas", :force => true do |t|
    t.integer  "vendedor_id", :null => false
    t.text     "texto",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pedidos", :force => true do |t|
    t.integer  "cliente_id",                      :null => false
    t.integer  "total_pedido",                    :null => false
    t.boolean  "aceptado",     :default => false, :null => false
    t.text     "comentario"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "productos", :force => true do |t|
    t.integer  "categoria_id",                                         :null => false
    t.integer  "proveedor_id",                                         :null => false
    t.string   "nombre",              :limit => 40,                    :null => false
    t.boolean  "granel",                            :default => false, :null => false
    t.integer  "precio_unitario",                                      :null => false
    t.integer  "stock_real",                                           :null => false
    t.integer  "stock_critico",                                        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "imagen_file_name"
    t.string   "imagen_content_type"
    t.integer  "imagen_file_size"
    t.datetime "imagen_updated_at"
  end

  create_table "proveedores", :force => true do |t|
    t.string   "nombre",              :limit => 40, :null => false
    t.integer  "cod_fono",            :limit => 2,  :null => false
    t.integer  "num_fono",                          :null => false
    t.string   "email"
    t.string   "nombre_encargado",    :limit => 40
    t.string   "apellidos_encargado", :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vendedores", :force => true do |t|
    t.integer  "rut",                                            :null => false
    t.string   "dv",            :limit => 1,                     :null => false
    t.string   "password",      :limit => 15,                    :null => false
    t.boolean  "administrador",               :default => false
    t.string   "nombre",        :limit => 40,                    :null => false
    t.string   "apellidos",     :limit => 40,                    :null => false
    t.string   "direccion"
    t.integer  "cod_fono",      :limit => 2
    t.integer  "num_fono"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ventas", :force => true do |t|
    t.integer  "pedido_id"
    t.integer  "vendedor_id",                               :null => false
    t.integer  "numero_boleta"
    t.integer  "total_venta",                               :null => false
    t.integer  "tipo_venta",    :limit => 2,                :null => false
    t.integer  "tipo_pago",     :limit => 2, :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "cierres_cajas", "vendedores", :name => "cierres_cajas_vendedor_id_fk"

  add_foreign_key "detallepedidos", "pedidos", :name => "detallepedidos_pedido_id_fk"
  add_foreign_key "detallepedidos", "productos", :name => "detallepedidos_producto_id_fk"

  add_foreign_key "detalleventas", "productos", :name => "detalleventas_producto_id_fk"
  add_foreign_key "detalleventas", "ventas", :name => "detalleventas_venta_id_fk"

  add_foreign_key "mermas", "productos", :name => "mermas_producto_id_fk"

  add_foreign_key "notas", "vendedores", :name => "notas_vendedor_id_fk"

  add_foreign_key "pedidos", "clientes", :name => "pedidos_cliente_id_fk"

  add_foreign_key "productos", "categorias", :name => "productos_categoria_id_fk"
  add_foreign_key "productos", "proveedores", :name => "productos_proveedor_id_fk"

  add_foreign_key "ventas", "pedidos", :name => "ventas_pedido_id_fk"
  add_foreign_key "ventas", "vendedores", :name => "ventas_vendedor_id_fk"

end
