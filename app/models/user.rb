class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :name, presence: true, length: { in: 1..255 }
  validates :email, presence: true, length: { in: 1..255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :projects, dependent: :destroy
  has_many :themes, through: :projects
  has_many :favorites, dependent: :destroy
  has_many :favorite_projects, through: :favorites, source: :project
end
