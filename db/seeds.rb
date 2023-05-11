require 'faker'

10.times do
  jewelry = Jewelry.create(
    name: Faker::Commerce.product_name,
    price: Faker::Commerce.price(range: 50..500, as_string: false),
    description: Faker::Lorem.sentence(word_count: 10)
  )
  # jewelry.image.attach(io: URI.open(Faker::LoremFlickr.image(size: "400x400", search_terms: ['fashion'])), filename: 'image.jpg')
end
