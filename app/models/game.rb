class Game < ApplicationRecord
  has_one_attached :cover_image

  def cover_image_url
    if self.cover_image.attachment
      self.cover_image.attachment.service_url
    else
      "/assets/pic_1.jpg"
    end
  end

  has_one_attached :game_zip

end
