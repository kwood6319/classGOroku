class GamesController < ApplicationController
  require "csv"
  require "cgi"

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)

    if params[:game][:instructions_file].present?
      file = params[:game][:instructions_file]
      instructions = CSV.read(file.path).flatten.reject(&:blank?).map do |i|
        sanitize_instruction(i)
      end
      @game.instructions = instructions
    end

    @game.status = "lobby"

    if @game.save
      params[:teams].each do |team_params|
        @game.teams.create(
          name: team_params[:name],
          color: team_params[:color],
          position: nil,
          on_board: false,
          turns_count: 0
        )
      end

      assign_goal_square

      redirect_to lobby_game_path(@game)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def lobby
    @game = Game.find(params[:id])
    @teams = @game.teams.order(:id)
  end

  def show
    @game = Game.find(params[:id])
    @teams = @game.teams.order(:id)
    @total_squares = @game.total_squares
    @visited_squares = @game.visited_squares || []
    @current_positions = @game.current_positions
    @historical_positions = @game.historical_positions
  end

  def start
    @game = Game.find(params[:id])
    @game.update(status: "active")
    redirect_to @game
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to new_game_path, notice: "Game ended."
  end

  private

  def game_params
    params.require(:game).permit(:grid_x, :grid_y)
  end

  def assign_goal_square
    available = (0...@game.total_squares).to_a
    @game.update(goal_square: available.sample)
  end

  def sanitize_instruction(text)
    CGI.unescapeHTML(text)
       .gsub("\u2018", "'").gsub("\u2019", "'")
       .gsub("\u201C", '"').gsub("\u201D", '"')
       .gsub("\u2013", "-").gsub("\u2014", "-")
       .gsub("\u2026", "...")
       .strip
  end
end
