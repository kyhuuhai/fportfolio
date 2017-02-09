class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :attachments, dependent: :destroy

  has_many :likes, as: :target
  has_many :comments, as: :target

  mount_uploader :image, ImageUploader

  enum target_type: {blog: 0, news: 1}

  ratyrate_rateable :rating

  scope :order_by_newest, ->{order created_at: :desc}
  scope :post_by_category_and_type, -> category_id, target_type do
    where category: category_id, target_type: target_type
  end

  scope :except_id, ->id do
    where("id != ?", id).limit 5
  end
end
