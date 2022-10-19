class Project < ApplicationRecord
  belongs_to :user
  has_many :themes, dependent: :destroy
  accepts_nested_attributes_for :themes, allow_destroy: true
end
