json.products @products.each do |product|
  json.partial! 'api/v1/products/info', product: product
end
