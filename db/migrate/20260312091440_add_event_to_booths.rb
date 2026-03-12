class AddEventToBooths < ActiveRecord::Migration[7.1]
  def change
    add_reference :booths, :event, null: false, foreign_key: true
  end
end
