class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    $board = Game.initialize_board
    # $adjacents = Game.adjacent_mines_count($board)
  end

  def get_adjacent_mines
    @tile_info = Game.adjacent_mines_count($board, params[:row].to_i, params[:col].to_i)
    @row = params[:row]
    @col = params[:col]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:game_id, :row, :col)
    end
end
