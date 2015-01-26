module Tienda
  class SettingsController < ApplicationController

    before_filter { @active_nav = :settings }

    def update
      if Tienda.settings.demo_mode?
        raise Tienda::Error, t('tienda.settings.demo_mode_error')
      end

      Tienda::Setting.update_from_hash(params[:settings].permit!)
      redirect_to :settings, notice: t('tienda.settings.update_notice')
    end

  end
end
