class Game < ApplicationRecord
  validates :name, presence: true, length: {minimum: 1, maximum: 50}
  validates :description, presence: true, length: {minimum: 1, maximum: 9000}

  has_one_attached :cover_image
  validates :cover_image, attached: true, content_type: [:png, :jpg, :jpeg], dimension: { width: 370, height: 254 }

  has_one_attached :icon_image
  validates :icon_image, attached: true, content_type: [:png, :jpg, :jpeg], dimension: { width: 150, height: 150 }

  has_one_attached :cover_image_big
  validates :cover_image_big, attached: true, content_type: [:png, :jpg, :jpeg], dimension: { width: 800, height: 549 }

  has_one_attached :game_zip
  validates :game_zip, attached: true, content_type: { in: 'application/zip', message: 'is not a ZIP' }

  belongs_to :category

  has_many :comments
  has_many :rankings , dependent: :destroy
end
