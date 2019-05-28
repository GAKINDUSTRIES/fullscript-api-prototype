json.products @products.each do |product|
  json.product do
    json.partial! 'api/v1/products/info', product: product
  end
end
