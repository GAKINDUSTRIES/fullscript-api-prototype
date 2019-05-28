json.id           product.id
json.name         product.name
json.status       product.status
json.current_rate product.current_rate
json.rated        product.rate_id.present?
json.rate_id      product.rate_id
json.image        product.file_url(type: :normal, object: :image)
json.small_thumb  product.file_url(type: :small_thumb, object: :image)
