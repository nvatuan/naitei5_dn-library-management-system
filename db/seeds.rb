# Create Categories
cate_edu = Category.create(name: "Educational")
cate_edu.children << Category.create(name: "Science")
cate_edu.children << Category.create(name: "Social")
cate_edu.children << Category.create(name: "Politics")
cate_edu.children << Category.create(name: "Finance")

cate_lit = Category.create(name: "Literature")
cate_novel = Category.create(name: "Novel")
cate_poem = Category.create(name: "Poem")

cate_lit.children << cate_novel << cate_poem

cate_novel.children << Category.create(name: "Fictional")
cate_novel.children << Category.create(name: "Romance")
cate_poem.children << Category.create(name: "Nature")

cates = Category.all

# Create Publishers
5.times {
  Publisher.create(
    name: Faker::Company.name,
    description: Faker::Lorem.paragraph(sentence_count: rand(4..10))
  )
}

pubs = Publisher.all

# Create Books
42.times {
  Book.create(
    title: Faker::Hipster.sentences.sample,
    category_id: cates.sample.id,
    publisher_id: pubs.sample.id,
    quantity: rand(0..10),
    description: Faker::Lorem.paragraph(sentence_count: rand(4..8)),
    published_date: Faker::Date.between(from: 10.years.ago, to: 1.year.ago),
    status: 2,
  )
}
Book.create(
  title: "Not published",
  category_id: cates.sample.id,
  publisher_id: pubs.sample.id,
  quantity: 0,
  description: "Not published",
  published_date: Date.today,
  status: 0,
)
Book.create(
  title: "Not available",
  category_id: cates.sample.id,
  publisher_id: pubs.sample.id,
  quantity: 0,
  description: "Not available",
  published_date: Date.today,
  status: 1,
)
