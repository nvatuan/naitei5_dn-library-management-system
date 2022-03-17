class Category < ApplicationRecord
  has_many :books, dependent: :nullify

  belongs_to :parent, class_name: Category.name, foreign_key: :parent_id,
              optional: true
  has_many :children, class_name: Category.name, foreign_key: :parent_id,
            dependent: :destroy
end
