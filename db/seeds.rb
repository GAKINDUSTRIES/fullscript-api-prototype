# Users
user = User.create! email: 'guillermo@techsniffer.me', password: 12345678

# Category
category = Category.create! name: 'New Category'

# Brands
brand = Brand.create! name: 'New Brand'

# Products
## AWS host
host_url = 'https://s3.amazonaws.com/fullscript/'

names = [
  'a Drenal',
  'Sleep formula',
  'Cortisol Manager',
  'ProOmega',
  'ProOmega 2000',
  'ProOmega 2000 Jr',
  'Bio Vegetarian',
  'Klaire Labs',
  'Seriphos',
  'Biocidin',
  'Mo-Zyme Forte',
  'Bone Broth',
  'Sleep Formula 2',
  'Elemental Powder',
  'Turmeric Force',
  'ProOmega 1450',
  'Klaire Labs COMPLETE'
]

17.times do |number|
  Product.create! name: names[number],
                  status: :available,
                  brand: brand,
                  category: category,
                  remote_image_url: host_url + "#{number}.jpg"
end
