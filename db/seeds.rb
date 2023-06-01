# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "Destroying data..."
  Book.destroy_all
  User.destroy_all

  user = User.create(email: 'gabriel@gmail.com', password: '123123')

  puts "Creating new seed"

  5.times do
    puts "creating book"
    year = (1990..2020).to_a.sample.to_s
    book = Book.create!(user: user, title: Faker::Book.title, details: Faker::Lorem.paragraph, author: Faker::Book.author, year: year)
    puts "#{book.title} created!" if book.save
  end
  