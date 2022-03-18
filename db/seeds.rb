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

books = Book.all

# Create Users
User.create(
  name: "admin",
  email: "admin@example.com",
  birthday: Faker::Date.between(from: "2004-01-01", to: "1995-01-01"),
  role: 1,
  activated: true,
  activated_at: Time.zone.now,
  password: "password123",
  password_confirmation: "password123",
)
tester = User.create(
  name: "tester",
  email: "tester@example.com",
  birthday: Faker::Date.between(from: "2004-01-01", to: "1995-01-01"),
  role: 0,
  activated: true,
  activated_at: Time.zone.now,
  password: "password123",
  password_confirmation: "password123",
)

15.times {
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    birthday: Faker::Date.between(from: "2004-01-01", to: "1995-01-01"),
    address: Faker::Address.full_address,
    phone: Faker::PhoneNumber.cell_phone,
    role: 0,
    activated: true,
    activated_at: Time.zone.now,
    password: "password123",
    password_confirmation: "password123",
  )
}

non_admins = User.where role: User.roles["user"]

# Create BorrowRequest
## Tester
10.times {
  BorrowRequest.create(
    borrowed_date: Faker::Date.backward(days: 99),
    return_date: Faker::Date.between(from: 10.days.before, to: 10.days.after),
    status: rand(0..5),
    user_id: tester.id,
    book_id: books.sample.id,
  )
}

## Random
51.times {
  BorrowRequest.create(
    borrowed_date: Faker::Date.backward(days: 99),
    return_date: Faker::Date.between(from: 10.days.before, to: 10.days.after),
    status: rand(0..5),
    user_id: non_admins.sample.id,
    book_id: books.sample.id,
  )
}
