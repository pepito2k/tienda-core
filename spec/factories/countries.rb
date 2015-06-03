module Tienda
  FactoryGirl.define do

    factory :country, class: Country do
      name        'United Kingdom'
      code2       'GB'
      code3       'GBR'
      continent   'EU'
      tld         'uk'
      currency    'GBP'
      eu_member   true

      factory :us do
        name        'United States of America'
        code2       'US'
        code3       'USA'
        continent   'NA'
        tld         'us'
        currency    'USD'
        eu_member   false
      end

      factory :france do
        name        'France'
        code2       'FR'
        code3       'FRA'
        continent   'EU'
        tld         'fr'
        currency    'EUR'
        eu_member   true
      end
    end

  end
end
