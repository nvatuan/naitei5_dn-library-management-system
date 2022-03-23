require "rails_helper"

RSpec.describe Book, type: :model do
  before :all do
    @b1 = Book.create! published_date: 3.days.ago, status: 0
    @b2 = Book.create! published_date: 2.days.ago, status: 1
    @b3 = Book.create! published_date: 4.days.ago, status: 2
  end

  it "correctly orders books by descending published date" do
    expect(Book.ordered_by_date).to eq([@b2, @b1, @b3])
  end

  it "correctly selects only published books" do
    expect(Book.published).to eq([@b2, @b3])
  end

  it "correctly destroys its own comments" do
    u = User.create! name: "test", email: "test@mail.com",
                      password: "password",
                      password_confirmation: "password"
    c = Comment.create! user: u
    b = Book.create!
    b.comments << c
    b.destroy

    expect(Comment.find_by id: c.id).to be_falsy

    u.destroy
  end

  after :all do
    @b = Book.create
    Book.destroy_all
  end
end
