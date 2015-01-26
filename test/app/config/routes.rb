Dummy::Application.routes.draw do
  mount Tienda::Engine, :at => '/tienda'
end
