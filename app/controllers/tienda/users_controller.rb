module Tienda
  class UsersController < Tienda::ApplicationController
    before_filter { @active_nav = :users }
    before_filter { params[:id] && @user = Tienda::User.find(params[:id]) }
    before_filter(only: [:create, :update, :destroy]) do
      if Tienda.settings.demo_mode?
        fail Tienda::Error, t('tienda.users.demo_mode_error')
      end
    end

    def index
      @users = Tienda::User.all
    end

    def new
      @user = Tienda::User.new
    end

    def create
      @user = Tienda::User.new(safe_params)
      if @user.save
        redirect_to :users, flash: { notice: t('tienda.users.create_notice') }
      else
        render action: 'new'
      end
    end

    def edit
    end

    def update
      if @user.update(safe_params)
        redirect_to [:edit, @user], flash: { notice: t('tienda.users.update_notice') }
      else
        render action: 'edit'
      end
    end

    def destroy
      fail Tienda::Error, t('tienda.users.self_remove_error') if @user == current_user
      @user.destroy
      redirect_to :users, flash: { notice: t('tienda.users.destroy_notice') }
    end

    private

    def safe_params
      params[:user].permit(:first_name, :last_name, :email_address, :password, :password_confirmation)
    end
  end
end
