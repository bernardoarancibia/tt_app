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

ActiveRecord::Schema.define(:version => 20101031185221) do

  create_table "categorias", :force => true do |t|
    t.string "nombre", :limit => 40, :null => false
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
    t.integer  "rut",                                           :null => false
    t.string   "dv",            :limit => 1,                    :null => false
    t.string   "password",      :limit => 15,                   :null => false
    t.boolean  "administrador",               :default => true
    t.string   "nombre",        :limit => 40,                   :null => false
    t.string   "apellidos",     :limit => 40,                   :null => false
    t.string   "direccion"
    t.integer  "cod_fono",      :limit => 2
    t.integer  "num_fono"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
