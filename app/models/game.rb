class Game < ApplicationRecord
  has_many :teams, dependent: :destroy
  has_many :turns, dependent: :destroy

  serialize :instructions, coder: JSON, type: Array
  serialize :visited_squares, coder: JSON, type: Array
  serialize :used_instructions, coder: JSON, type: Array

  def total_squares
    grid_x * grid_y
  end

  def square_visited?(square)
    (visited_squares || []).map(&:to_i).include?(square.to_i)
  end

  def visit_square(square)
    self.visited_squares ||= []
    visited_squares << square.to_i
    save
  end

  def random_instruction
    self.used_instructions ||= []
    available = instructions - used_instructions

    if available.empty?
      self.used_instructions = []
      available = instructions
    end

    instruction = available.sample
    used_instructions << instruction
    save
    instruction
  end

  def current_positions
    teams.each_with_object({}) do |team, hash|
      next unless team.on_board

      hash[team.position] ||= []
      hash[team.position] << team
    end
  end

  def historical_positions
    all_turns = turns.includes(:team).order(:id)
    current = teams.each_with_object({}) { |t, h| h[t.id] = t.position if t.on_board }

    all_turns.each_with_object({}) do |turn, hash|
      next if current[turn.team_id] == turn.square

      hash[turn.square] ||= []
      hash[turn.square] << turn.team unless hash[turn.square].map(&:id).include?(turn.team_id)
    end
  end
end
