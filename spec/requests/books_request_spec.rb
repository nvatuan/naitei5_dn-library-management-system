require 'rails_helper'

RSpec.describe "books", type: :request do
  describe "GET /index" do
    it "render the index template" do
      get "/books"
      expect(response).to render_template(:index)
    end
  end

  describe "GET /show" do
    context "when book id valid" do
      before do
        book = FactoryBot.create(:book)
        get "/books/#{book.id}"
      end
      it "render show when params id valid " do
        expect(response).to render_template(:show)
      end
    end

    context "when book not found" do
      before {get "/books/-1"}

      it "display flash warning " do
        expect(flash[:danger]).to eq "This book cannot be found!"
      end

      it "redirect root page" do
        expect(response).to redirect_to books_path
      end
    end
  end
end
