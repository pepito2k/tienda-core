module Tienda
  class ProductCategory < ActiveRecord::Base

    # Mount Uploader
    mount_uploader :image, CategoryImageUploader

    # All products within this category
    has_many :products, dependent: :restrict_with_exception
    has_many :active_featured_root_products, -> { where(active: true, featured: true, parent_id: nil) }, class_name: 'Tienda::Product'
    # Sub Categories relationships
    has_many :children, class_name: 'Tienda::ProductCategory', foreign_key: :parent_id
    belongs_to :parent, class_name: 'Tienda::ProductCategory'

    # Validations
    validates :name, presence: true
    validates :permalink, presence: true, uniqueness: true, permalink: true

    # All categories ordered by their name ascending
    scope :ordered, -> { order(:name) }
    scope :root, -> { where(parent_id: nil) }
    scope :sub_categories, -> { where.not(parent_id: nil) }

    # Set the permalink on callback
    before_validation { self.permalink = self.name.parameterize if self.permalink.blank? && self.name.is_a?(String) }

  end
end
