# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( tienda/morris-0.4.3.min.css tienda/custom-styles.css )
Rails.application.config.assets.precompile += %w( tienda/jquery.metisMenu.js tienda/raphael-2.1.0.min.js tienda/morris.js tienda/custom-scripts.js )
