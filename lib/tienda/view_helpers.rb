module Tienda
  module ViewHelpers
    # Returns currency values with the currency unit as specified by
    # the Tienda settings
    def number_to_currency(number, options = {})
      options[:unit] ||= Tienda.settings.currency_unit
      super
    end

    # Returns a number of kilograms with the appropriate suffix
    def number_to_weight(kg)
      "#{kg}#{t('tienda.helpers.number_to_weight.kg', default: 'kg')}"
    end
  end
end
