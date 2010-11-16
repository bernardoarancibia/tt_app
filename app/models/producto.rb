#encoding: utf-8

class Producto < ActiveRecord::Base

  belongs_to :categoria
  belongs_to :proveedor
  
  has_many :mermas
  has_many :detalleventas
  has_many :detallepedidos
  has_attached_file :imagen

  before_validation :downcase_nombre

  validates :nombre, :length => { :maximum => 40 }
  validates_format_of :nombre,
    :with => /^([A-Za-z0-9ÁÉÍÓÚáéíóúÑÜñü]{1,})([ A-Za-z0-9ÁÉÍÓÚáéíóúÑÜñü\/&-]{1,})$/, :allow_nil => true

  validates_uniqueness_of :nombre, :case_sensitive => false

  validates_numericality_of :precio_unitario,
    :less_than => 9999999, :greater_than_or_equal_to => 1

  validates_presence_of :stock_real, :stock_critico

  validates_numericality_of :stock_real,
    :less_than => 99999, :greater_than_or_equal_to => 1,
    :unless => "stock_real.nil?"

  validates_numericality_of :stock_critico,
    :less_than => 99999, :greater_than_or_equal_to => 1,
    :unless => "stock_critico.nil?"

  validate :diferencia_stocks

  # Validaciones Paperclip -----
  #
  has_attached_file :imagen, :styles => { :small => "150x150>" },
    :url => "productos/:style/:id.:extension",
    :path => ":rails_root/public/images/productos/:style/:id.:extension",
    :default_url => '/images/icons/producto_default.png',
    :allow_nil => true

  validates_attachment_content_type :imagen, :content_type => ["image/jpg", "image/png"], :allow_nil => true,
    :unless => Proc.new {|img| img[:imagen].nil? },
    :message => " : Solo imagenes .jpg y .png" #unless :imagen

 validates_attachment_size :imagen, :less_than => 1.megabytes, :allow_nil => true,
     :message => "No se pueden subir fotos mayores a 1 MB"



  protected #-----

  def diferencia_stocks
    unless stock_critico.nil? || stock_real.nil?
      errors.add(:stock_real, "debe ser mayor que el stock crítico") if
      stock_critico >= stock_real
    end
  end

  def downcase_nombre
    self.nombre.downcase!
  end

end
