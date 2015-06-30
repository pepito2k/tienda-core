class ConvertProductImagesToCarrierwave < ActiveRecord::Migration
  PRODUCT_IMAGE_TYPES = [:default_image, :second_image, :third_image, :fourth_image, :fifth_image]
  def up
    # Product Images
    PRODUCT_IMAGE_TYPES.each do |image_type|
      puts "Converting Product's #{image_type}s"
      sql = "SELECT parent_id, file_name, data FROM nifty_attachments WHERE parent_type = 'Tienda::Product' AND role = '#{image_type}'"
      ActiveRecord::Base.connection.execute(sql).each do |attachment|
        File.open(attachment[1], 'wb') { |f| f.write(attachment[2]) }
        image = Tienda::ProductImage.new
        image.product_id = attachment[0]
        File.open(attachment[1], 'r') { |f| image.image = f }
        image.save
        File.delete(attachment[1])
      end
    end

    #Product Categories Images
    puts "Converting Product Categoeies' images"
    sql = "SELECT parent_id, file_name, data FROM nifty_attachments WHERE parent_type = 'Tienda::ProductCategory'"
    ActiveRecord::Base.connection.execute(sql).each do |attachment|
      File.open(attachment[1], 'wb') { |f| f.write(attachment[2]) }
      category = Tienda::ProductCategory.find attachment[0]
      File.open(attachment[1], 'r') { |f| category.image = f }
      category.save
      File.delete(attachment[1])
    end

    drop_table :nifty_attachments
  end
end
