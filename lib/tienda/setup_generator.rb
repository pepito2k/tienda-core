require 'rails/generators'
module Tienda
  class SetupGenerator < Rails::Generators::Base
    def create_route
      route 'mount Tienda::Engine => "/tienda"'
    end
  end
end
