class TurnsController < ApplicationController
  def create
    @game  = Game.find(params[:game_id])
    @team  = @game.teams.find(params[:team_id])
    square = params[:square].to_i

    record_turn(square)

    if square == @game.goal_square
      handle_win
    else
      handle_instruction(square)
    end
  end

  private

  def record_turn(square)
    Turn.create(game: @game, team: @team, square: square)
    @team.update(
      position: square,
      on_board: true,
      turns_count: @team.turns_count + 1
    )
    @game.visit_square(square)
  end

  def handle_win
    @game.update(status: "finished")
    redirect_to @game, notice: "WIN:#{@team.name}"
  end

  def handle_instruction(square)
    instruction = @game.random_instruction
    @team.update(last_instruction: instruction)
    redirect_to @game, notice: "INSTRUCTION:#{@team.color}:#{instruction}"
  end
end
