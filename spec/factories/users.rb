module Tienda
  FactoryGirl.define do

    factory :user, class: User do
      first_name              'Gonzalo'
      last_name               'Robaina'
      email_address           'gonzalo@robaina.me'
      password                'qwerty123'
      password_confirmation   'qwerty123'
    end

  end
end
