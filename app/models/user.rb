class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :purchases

  with_options presence: true do
    validates :nickname
    validates :birthday
  end

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX

  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/ } do
    validates :family_name
    validates :first_name
  end

  with_options presence: true, format: { with: /\A[ァ-ン]+\z/ } do
    validates :family_name_kana
    validates :first_name_kana
  end
end
