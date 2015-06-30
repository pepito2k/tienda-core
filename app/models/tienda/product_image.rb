module Tienda
  class ProductImage < ActiveRecord::Base
    # Relationships
    belongs_to :product

    # Mount Uploaders
    mount_uploader :image, ProductImageUploader
  end
end
