module Tienda
  class SessionsController < Tienda::ApplicationController

    layout 'tienda/sub'
    skip_before_filter :login_required, only: [:new, :create, :reset]

    def create
      if user = Tienda::User.authenticate(params[:email_address], params[:password])
        session[:tienda_user_id] = user.id
        redirect_to :root
      else
        flash.now[:alert] = t('tienda.sessions.create_alert')
        render action: "new"
      end
    end

    def destroy
      session[:tienda_user_id] = nil
      redirect_to :login
    end

    def reset

      if request.post?
        if user = Tienda::User.find_by_email_address(params[:email_address])
          user.reset_password!
          redirect_to login_path(email_address: params[:email_address]), notice: t('tienda.sessions.reset_notice', email_address: user.email_address)
        else
          flash.now[:alert] = t('tienda.sessions.reset_alert')
        end
      end
    end
  end
end
