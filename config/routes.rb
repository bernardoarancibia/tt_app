TtApp::Application.routes.draw do

  resources :creditos

  root :to => "pages#index"

 # get "pages/home"
  match '/home' => 'pages#index'

 # get "pages/about"
  match '/about' => 'pages#about'

 #get "pages/login"
  match '/login_ventas' => 'pages#login_ventas'
  match '/login_clientes' => 'pages#login_clientes'

  match 'logout' => 'pages#logout'

  match 'catalogo' => 'pages#catalogo'
  match 'pedidos_clientes' => 'pages#pedidos_clientes'
  match 'creditos_clientes' => 'pages#creditos_clientes'

  match 'carrito' => 'pages#carrito'
  match 'empty_carrito' => 'pages#empty_carrito'

  match 'add_to_carrito(/:id)' => 'pages#add_to_carrito'
  match 'remove_from_carrito(/:id)' => 'pages#remove_from_carrito'
  match 'update_carrito(/:cantidad)' => 'pages#update_carrito'

  match 'enviar_pedido' => 'pages#enviar_pedido'
  
  match 'cierre_venta' => 'pages#cierre_vs_venta'
  
  match 'grafico' => 'pages#prod_mas_vendidos'

  match 'aceptar_pedido(/:id)' => 'ventas#aceptar_pedido'
  match 'libro_ventas(/:libro)' => 'ventas#libro_ventas'

  match 'productos/buscar'
  match 'proveedores/buscar'
  match 'mermas/buscar'
  match 'creditos/buscar'
  match 'vendedores/buscar'
  match 'clientes/buscar'
  match 'ventas/buscar_boleta'

  resources :detallepedidos

  resources :pedidos

  resources :detalleventas

  resources :ventas

  resources :mermas

  resources :productos

  resources :cierres_cajas

  resources :pages

  resources :notas

  resources :vendedores

  resources :clientes

  resources :categorias

  resources :proveedores

  #------------Nested Routes Proveedores----------------#

  resources :proveedores do
      resources :productos
  end

  #------------Nested Routes Categorias----------------#

  resources :categorias do
      resources :productos
  end

  #------------Nested Routes Vendedores----------------#

  resources :vendedores do
      resources :notas, :ventas, :cierres_cajas
      member do
        put 'update_perfil'
      end
  end

  #------------Nested Routes Productos----------------#

  resources :productos do
      resources :detalleventas, :detallepedidos, :mermas
      member do
        get 'buscar'
      end
  end

  #------------Nested Routes Ventas----------------#

  resources :ventas do
      resources :detalleventas
      member do
        get 'anular'
        get 'pagar_credito'
      end
  end


  #------------Nested Routes Pedidos----------------#

  resources :pedidos do
      resources :detallepedidos
  end

  #------------Nested Routes Clientes----------------#

  resources :clientes do
      resources :pedidos, :creditos
      member do
        put 'update_perfil'
      end
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  #match ':controller(/:action(/:id(.:format)))'
end
