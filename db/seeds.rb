# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

cate = Category.create(name: "Fictional")
publ = Publisher.create(name: "FPubl", description: "This publisher publishes "\
                                                    "fictional works.")

42.times {
  Book.create(
    title: Faker::Hipster.sentences.sample,
    category_id: cate.id,
    publisher_id: publ.id,
    description: Faker::Lorem.paragraph(sentence_count: rand(4..8)),
    status: 2,
  )
}
Book.create(
  title: "Not published",
  category_id: cate.id,
  publisher_id: publ.id,
  description: "Not published",
  status: 0,
)
Book.create(
  title: "Not available",
  category_id: cate.id,
  publisher_id: publ.id,
  description: "Not available",
  status: 1,
)
