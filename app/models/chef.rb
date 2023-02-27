class Chef < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :rememberable, :validatable, :timeoutable

  has_many :recipes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :chefname, presence: true, length: {maximum: 30}
  validates :email, length: {maximum: 255}

  scope :chefname_asc, -> { order("lower(chefname) asc") }
end
