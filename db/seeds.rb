require 'faker'

10.times do
  jewelry = Jewelry.create(
    name: Faker::Commerce.product_name,
    price: Faker::Commerce.price(range: 50..500, as_string: false),
    description: Faker::Lorem.sentence(word_count: 10),
    image_url: Faker::LoremPixel.image(size: "400x400", category: 'fashion')
  )
end
