titles = %{8 Class Pets + 1 Squirrel ÷ 1 Dog = Chaos
Adventure According to Humphrey
The Adventures of a South Pole Pig
Almost Super
Appleblossom the Possum
Ban This Book
Bat and the Waiting Game
Because of Mr. Terupt
​Because of the Rabbit
​Because of Winn-Dixie
​The BFG
​Billy Sure Kid Entrepreneur
​Booked
​Bookmarks Are People Too!
​A Boy Called Bat
​The Boy Who Harnessed the Wind
​Brambleheart
​Brown Girl Dreaming
​Bud, Not Buddy
​Charlie and the Chocolate Factory
​Charlie Bumpers vs. The Teacher of the Year
​Charlotte’s Web
​The Chocolate Touch
​Class Dismissed
​Clementine
​Cleo Edison Oliver, Playground Millionaire
​Cody Harmon, King of Pets
​Counting by 7s
​Crenshaw
​The Cricket in Times Square
​The Crossover
​Dog Days
​Dragons and Marshmallows
​Dragons in a Bag
​Drita, My Homegirl
​El Deafo
​EllRay Jakes Is a Rock Star!
​The Enormous Egg
​Escape from Mr. Lemoncello’s Library
​Esperanza Rising
​Fantastic Mr. Fox
​Fenway and Hattie
​Finding Langston
​The First Rule of Punk
​Fish in a Tree
​Flora & Ulysses
Flying Lessons &amp; Other Stories
​The Fourteenth Goldfish
​Frank Einstein and the Electro-Finger
​Friendship According to Humphrey
​​Frindle
​From the Desk of Zoe Washington
​From the Mixed-Up Files of Mrs. Basil E. Frankweiler
​Ghost
​Gooney Bird Greene
​Gooseberry Park
Gooseberry Park and the Master Plan
Granny Torrelli Makes Soup
Niagara Falls, Or Does It?
Harbor Me
Holes
Hoot
How to Eat Fried Worms
I Am Malala
Insignificant Events in the Life of a Cactus
Island of the Blue Dolphins
James and the Giant Peach
Jeremy Thatcher, Dragon Hatcher
Judy Moody
Keena Ford and the Second-Grade Mix-Up
Kenny &amp; the Dragon
The Lemonade Crime
The Lemonade War
Life According to Og the Frog
The Lion, the Witch and the Wardrobe
Lola Levine Is Not Mean!
A Long Walk to Water
Look Both Ways
Love That Dog
Lunch Money
Malala: My Story of Standing Up for Girls’ Rights
Malamander
Masterpiece
Matilda
Merci Suárez Changes Gears
The Miraculous Journey of Edward Tulane
The Mouse and the Motorcycle
Mr. Popper’s Penguins
Mrs. Frisby and the Rats of NIMH
My Father’s Dragon
My Side of the Mountain
Mysteries According to Humphrey
The Mysterious Abductions
A Nest for Celeste
The Next Great Paulie Fink
Nim’s Island
No Talking
Nuts to You
The One and Only Ivan
Out of My Mind
The Pet War
Pie
Poppy
Project Mulberry
Refugee
Rescue on the Oregon Trail
Restart
Riding Freedom
Rules
Rump
Save Me a Seat
Saving Winslow
School Days According to Humphrey
Shiloh
Sideways Stories from Wayside School
So B. It
Stella Díaz Has Something to Say
Stone Fox
Stuart Little
Summer According to Humphrey
Summer of the Monkeys
The Tale of Despereaux
Tales of a Fourth Grade Nothing
The Terrible Two
The Toothpaste Millionaire
Toys Go Out
Toys! Amazing Stories Behind Some Great Inventions
The Trumpet of the Swan
Tuck Everlasting
Upside-Down Magic
Walk Two Moons
The Wanderer
The Water Horse
The Watsons Go to Birmingham—1963
Ways to Make Sunshine
We Can’t All Be Rattlesnakes
The Wednesday Wars
Where the Mountain Meets the Moon
The Wild Robot
Winter According to Humphrey
Wish
Wishtree
Wonder
The Wonderful Wizard of Oz
The World According to Humphrey
The Year of Billy Miller
The Year of the Dog
}.split("\n")

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
15.times {
  Publisher.create(
    name: Faker::Company.name,
    description: Faker::Lorem.paragraph(sentence_count: rand(4..10))
  )
}

pubs = Publisher.all

# Create Books
titles.each { |t|
  Book.create(
    title: t,
    category_id: cates.sample.id,
    publisher_id: pubs.sample.id,
    quantity: rand(0..10),
    description: Faker::Lorem.paragraph(sentence_count: rand(4..8)),
    published_date: Faker::Date.between(from: 10.years.ago, to: 1.year.ago),
    status: rand(0..2),
  )
}

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

8.times {
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
  bdate = Faker::Date.backward(days: 10)
  rdate = Faker::Date.between(from: 10.days.after, to: 30.days.after)
  status = rand(0..5)
  adate = (status == 3 ? Faker::Date.between(from: bdate, to: rdate) : nil)

  BorrowRequest.create(
    created_at: bdate,
    borrowed_date: bdate,
    return_date: rdate,
    actual_return_date: adate,
    status: status,
    user_id: tester.id,
    book_id: books.sample.id,
  )
}

## Random
62.times {
  bdate = Faker::Date.backward(days: 10)
  rdate = Faker::Date.between(from: 10.days.after, to: 30.days.after)
  status = rand(0..5)
  adate = (status == 3 ? Faker::Date.between(from: bdate, to: rdate) : nil)

  BorrowRequest.create(
    borrowed_date: Faker::Date.backward(days: 99),
    return_date: Faker::Date.between(from: 10.days.before, to: 10.days.after),
    status: rand(0..5),
    user_id: non_admins.sample.id,
    book_id: books.sample.id,
  )
}
