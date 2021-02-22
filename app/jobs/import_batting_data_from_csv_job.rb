class ImportBattingDataFromCsvJob < ApplicationJob
  queue_as :default

  def perform(file_path)
    BattingAverage.delete_all
    BattingAverage.import(file_path)
  end
end
