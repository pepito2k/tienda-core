module Tienda
  FactoryGirl.define do

    factory :tax_rate, class: TaxRate do
      name          'Standard Tax'
      rate          20.0
      address_type  ['billing', 'delivery'].sample

      factory :exempt_tax do
        name          'Exempt Tax'
        rate          0.0
      end
    end

  end
end
