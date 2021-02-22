class BattingAverage < ApplicationRecord
  validates :player_id, uniqueness: { scope: :year_id }

  default_scope { order(average: :desc) }
  scope :search_by_player_id, lambda { |player_id| where("player_id LIKE CONCAT('%',?,'%')", player_id&.downcase) }
  scope :search_by_year, lambda { |year| where(year_id: year) }

  def self.import(file_path)
    CSV.foreach(file_path, headers: true) do |row|
      item = {}
      row = row.to_hash
      item[:player_id] = row['playerID']
      item[:year_id] = row ['yearID']
      item[:team_name] = row['teamID']
      item[:average] = calculate_average(row['H']&.to_d, row['AB']&.to_d)

      BattingAverage.find_or_create_by(item)
    end
  end

  def self.calculate_average(h, ab)
    return 0 if h.eql?(0) || ab.eql?(0) || h.nil? || ab.nil?

    h / ab
  end

  def self.fetch_years
    BattingAverage.unscoped.select('DISTINCT year_id').map(&:year_id)
  end
end
