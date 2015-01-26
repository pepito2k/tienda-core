module Tienda
  class UserMailer < ActionMailer::Base

    def new_password(user)
      @user = user
      mail :from => Tienda.settings.outbound_email_address, :to => user.email_address, :subject => "Your new Tienda password"
    end

  end
end
