class Theme < ApplicationRecord
  validates :first_theme, presence: true, length: { in: 1..255 }
  validates :second_theme, presence: true, length: { in: 1..255 }
  validates :third_theme, presence: true, length: { in: 1..255 }
  belongs_to :project
end
