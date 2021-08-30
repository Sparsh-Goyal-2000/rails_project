namespace :set_catagory do
  desc 'Set uncategorized products category to first category'
  task port_legacy_products: :environment do
    first_catagory = Catagory.first
    Product.where(catagory_id: nil) do |product|
      product.catagory = first_catagory
      product.save
    end
  end
end