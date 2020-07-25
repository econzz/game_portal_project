class Ranking < ApplicationRecord
    belongs_to :player, class_name: 'Player', foreign_key: 'players_id'
    belongs_to :game, class_name: 'Game', foreign_key: 'game_id'
end
