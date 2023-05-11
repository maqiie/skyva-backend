require 'faker'

puts "Seeding Jewelries..."
5.times do
  Jewelry.create(
    name: Faker::Commerce.product_name,
    price: Faker::Commerce.price(range: 100..1000),
    description: Faker::Lorem.sentence
  )
end

puts "Jewelries seeded successfully!"
