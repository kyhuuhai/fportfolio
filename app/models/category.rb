class Category < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :projects, dependent: :destroy

  enum target_type: {blog: 0, news: 1}
end
