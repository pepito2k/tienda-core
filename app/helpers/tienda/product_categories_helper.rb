module Tienda
  module ProductCategoriesHelper

    def product_category_spacing(category, relative_depth)
      ("<span style='display:inline-block;width:#{relative_depth}em;'></span>").html_safe
    end

    def product_category_rows(category, current_category = nil, link_to_current = true, relative_depth = 0)
      if category.present? && category.children.any?
        relative_depth += 1
        String.new.tap do |s|
          category.children.ordered.each do |child|
            s << '<tr><td>'
            if child == current_category
              if link_to_current == false
                s << "#{product_category_spacing child, relative_depth} &#8627; #{child.name} (#{t('shoppe.product_category.nesting.current_category')})"
              else
                s << "#{product_category_spacing child, relative_depth} &#8627; #{link_to(child.name, [:edit, child]).html_safe} (#{t('shoppe.product_category.nesting.current_category')})"
              end
            else
              s << "#{product_category_spacing child, relative_depth} &#8627; #{link_to(child.name, [:edit, child]).html_safe}"
            end
            s << '</td></tr>'
            s << product_category_rows(child, current_category, link_to_current, relative_depth)
          end
        end.html_safe
      else
        ''
      end
    end

    def product_categories_options_for_select(selected = nil, disable = nil)
      String.new.tap do |s|
        Tienda::ProductCategory.root.ordered.includes(:children).each do |category|
          s << product_categories_options_for_select_recursive(category, 0, selected, disable)
        end
      end.html_safe
    end

    def product_categories_options_for_select_recursive(category, depth, selected, disable)
      if category.present?
        String.new.tap do |s|
          s << "<option value='#{category.id}'#{' selected' if selected == category.id}#{' disabled' if disable == category.id}>#{' &#8627; ' * depth}#{category.name}</option>"
          if category.children.any?
            depth += 1
            category.children.ordered.each do |child|
              s << product_categories_options_for_select_recursive(child, depth, selected, disable)
            end
          end
        end.html_safe
      else
        ''
      end
    end
  end
end
