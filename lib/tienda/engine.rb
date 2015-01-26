module Tienda
  class Engine < ::Rails::Engine
    isolate_namespace Tienda

    if Tienda.respond_to?(:root)
      config.autoload_paths << File.join(Tienda.root, 'lib')
      config.assets.precompile += ['tienda/sub.css', 'tienda/printable.css']
    end

    # We don't want any automatic generators in the engine.
    config.generators do |g|
      g.orm             :active_record
      g.test_framework  false
      g.stylesheets     false
      g.javascripts     false
      g.helper          false
    end

    initializer 'tienda.initialize' do |app|
      # Add the default settings
      Tienda.add_settings_group :system_settings, [:store_name, :email_address, :currency_unit, :tax_name, :demo_mode]

      # Add middleware
      app.config.middleware.use Tienda::SettingsLoader

      # Load our migrations into the application's db/migrate path
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end

      # Load view helpers for the base application
      ActiveSupport.on_load(:action_view) do
        require 'tienda/view_helpers'
        ActionView::Base.send :include, Tienda::ViewHelpers
      end

      # Load default navigation
      require 'tienda/default_navigation'
    end

    generators do
      require 'tienda/setup_generator'
    end

  end
end
