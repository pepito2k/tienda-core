module Tienda
  class ProductCategoriesController < Tienda::ApplicationController

    before_filter { @active_nav = :product_categories }
    before_filter { params[:id] && @product_category = Tienda::ProductCategory.find(params[:id]) }

    def index
      @product_categories = Tienda::ProductCategory.ordered.all
    end

    def new
      @product_category = Tienda::ProductCategory.new
    end

    def create
      @product_category = Tienda::ProductCategory.new(safe_params)
      if @product_category.save
        redirect_to :product_categories, flash: { notice: t('tienda.product_category.create_notice') }
      else
        render action: "new"
      end
    end

    def edit
    end

    def update
      if @product_category.update(safe_params)
        redirect_to [:edit, @product_category], flash: { notice: t('tienda.product_category.update_notice') }
      else
        render action: "edit"
      end
    end

    def destroy
      @product_category.destroy
      redirect_to :product_categories, flash: { notice: t('tienda.product_category.destroy_notice') }
    end

    private

    def safe_params
      params[:product_category].permit(:name, :permalink, :description, :image_file)
    end

  end
end
