class Game < ApplicationRecord
  validates :name, presence: true, length: {minimum: 1, maximum: 50}
  validates :description, presence: true, length: {minimum: 1, maximum: 300}

  has_one_attached :cover_image
  validates :cover_image, attached: true, content_type: [:png, :jpg, :jpeg]

  

  has_one_attached :game_zip
  validates :game_zip, attached: true, content_type: { in: 'application/zip', message: 'is not a ZIP' }

  
end
