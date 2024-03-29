# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


categories = [
    "Clothing",
    "Shoes",
    "Jewelery",
    "Watches",
    "Books",
    "Smart Home",
    "Home",
    "Garden",
    "Tools",
    "Pet Supplies",
    "Beauty",
    "Health",
    "Fitness",
    "Toys",
    "Kids/Baby",
    "Handmade",
    "Sports",
    "Outdoors",
    "Automotive",
    "Computers",
    "Entertainment",
    "Antique",
    "Phones"]

categories.each do |name|
    Category.create(name: name)
end