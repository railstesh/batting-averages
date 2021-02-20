class CreateBattingAverages < ActiveRecord::Migration[6.0]
  def change
    create_table :batting_averages do |t|
      t.string :player_id
      t.integer :year_id
      t.string :team_name
      t.decimal :average, precision: 15, scale: 3

      t.timestamps
    end
  end
end
