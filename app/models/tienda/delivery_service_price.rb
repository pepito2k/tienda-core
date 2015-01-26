module Tienda
  class DeliveryServicePrice < ActiveRecord::Base

    # Set the table name
    self.table_name = 'tienda_delivery_service_prices'

    include Tienda::AssociatedCountries

    # The delivery service which this price belongs to
    belongs_to :delivery_service, :class_name => 'Tienda::DeliveryService'

    # The tax rate which should be applied
    belongs_to :tax_rate, :class_name => "Tienda::TaxRate"

    # Validations
    validates :code, :presence => true
    validates :price, :numericality => true
    validates :cost_price, :numericality => true, :allow_blank => true
    validates :min_weight, :numericality => true
    validates :max_weight, :numericality => true

    # All prices ordered by their price ascending
    scope :ordered, -> { order(:price => :asc) }

    # All prices which are suitable for the weight passed.
    #
    # @param weight [BigDecimal] the weight of the order
    scope :for_weight, -> weight { where("min_weight <= ? AND max_weight >= ?", weight, weight) }

  end
end
