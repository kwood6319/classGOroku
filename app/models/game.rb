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
end
