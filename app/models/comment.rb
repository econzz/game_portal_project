class Comment < ApplicationRecord
    belongs_to :games

    validates :commenter, presence: true, length: {minimum: 1, maximum: 50}
    validates :content, presence: true, length: {minimum: 1, maximum: 300}
end
