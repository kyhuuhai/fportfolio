class User < ApplicationRecord
  rolify
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, omniauth_providers: [:facebook, :twitter]

  has_many :socials, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :participates, dependent: :destroy
  has_many :projects, through: :participates
  has_many :techniques, through: :target_techniques
  has_many :messages, dependent: :destroy
  has_many :certificate_users, dependent: :destroy
  has_many :certifications, through: :certificate_users
  has_many :likes, as: :target
  has_many :images, as: :target
  has_many :target_techniques, as: :target

  ROLES = {admin: "Admin", user: "User"}

  validates :name, presence: true, length: {maximum: Settings.user.name}

  scope :order_by_newest, ->{order created_at: :desc}

  ratyrate_rateable :rating

  ratyrate_rater

  def self.from_omniauth auth
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name unless auth.info.name.nil?
      user.email = auth.info.email unless auth.info.email.nil?
      user.password = Devise.friendly_token[0,20]
    end
  end
end
