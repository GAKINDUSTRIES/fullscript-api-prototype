json.id           product.id
json.name         product.name
json.status       product.status
json.rating       product.current_rate
json.rated        product.rate_id.present?
json.rate_id      product.rate_id
json.rate_value   product.rate_value
json.image        product.image.url
json.normal_image product.file_url(type: :normal, object: :image)
json.small_thumb  product.file_url(type: :small_thumb, object: :image)
