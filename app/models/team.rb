class Team < ApplicationRecord
  belongs_to :game
  has_many :turns, dependent: :destroy
end
