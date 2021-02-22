class BattingAveragesController < ApplicationController
  def index
    @batting_averages = fetch_averages
  end

  def new; end

  def import_csv_data
    ImportBattingDataFromCsvJob.perform_later("#{Rails.root}/public/Batting.csv") if params[:file].present?
    redirect_to root_path
  end

  private

  def fetch_averages
    averages = BattingAverage.all
    averages = averages.search_by_player_id(params[:player_id]) if params[:player_id].present?
    averages = averages.search_by_year(params[:year_id]) if params[:year_id].present?
    averages
  end
end
