class Project < ApplicationRecord
  belongs_to :user
  has_many :themes, dependent: :destroy
end
