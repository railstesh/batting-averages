module BattingAveragesHelper
  def average_present?
    BattingAverage.any?
  end
end
