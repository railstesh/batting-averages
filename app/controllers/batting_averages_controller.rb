class BattingAveragesController < ApplicationController
  def index
    @batting_averages = fetch_averages
  end

  def import_csv_data
    binding.pry
    BattingAverage.import()
  end

  private

  def fetch_averages
    averages = BattingAverage.all
    averages = averages.search_by_player_id(params[:player_id]) if params[:player_id].present?
    averages = averages.search_by_player_id(params[:year_id]) if params[:year_id].present?
    averages
  end
end
