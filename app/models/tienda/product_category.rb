module Tienda
  class ProductCategory < ActiveRecord::Base

    self.table_name = 'tienda_product_categories'

    # Categories have an image attachment
    attachment :image

    # All products within this category
    has_many :products, :dependent => :restrict_with_exception, :class_name => 'Tienda::Product'

    # Validations
    validates :name, :presence => true
    validates :permalink, :presence => true, :uniqueness => true, :permalink => true

    # All categories ordered by their name ascending
    scope :ordered, -> { order(:name) }

    # Set the permalink on callback
    before_validation { self.permalink = self.name.parameterize if self.permalink.blank? && self.name.is_a?(String) }

  end
end
