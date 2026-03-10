class AddPowerDetailsToDailyDetails < ActiveRecord::Migration[7.1]
  def change
    add_column :daily_details, :power_usage, :integer
    add_column :daily_details, :power_purpose, :string
  end
end
