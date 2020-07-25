class Player < ApplicationRecord
    has_many :rankings , dependent: :destroy
end
