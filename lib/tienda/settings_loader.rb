module Tienda
  class SettingsLoader

    def initialize(app)
      @app = app
    end

    def call(env)
      Tienda.reset_settings
      @app.call(env)
    ensure
      Tienda.reset_settings
    end

  end
end
