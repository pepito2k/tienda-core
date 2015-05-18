module Tienda
  class StockLevelAdjustment < ActiveRecord::Base
    # The product which the stock level adjustment belongs to
    belongs_to :product

    # The parent (OrderItem) which the stock level adjustment belongs to
    belongs_to :parent, polymorphic: true

    # Save stock cache into Products table
    counter_culture :product, column_name: :stock_count, delta_column: :adjustment

    # Validations
    validates :description, presence: true
    validates :adjustment, numericality: true
    validate { errors.add(:adjustment, I18n.t('tienda.activerecord.attributes.stock_level_adjustment.must_be_greater_or_equal_zero')) if adjustment == 0 }

    # All stock level adjustments ordered by their created date desending
    scope :ordered, -> { order(id: :desc) }

  end
end
