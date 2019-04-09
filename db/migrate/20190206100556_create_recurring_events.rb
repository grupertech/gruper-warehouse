class CreateRecurringEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :recurring_events do |t|
      t.string :title
      t.date :anchor
      t.integer :frequency, limit: 1, default: 0
      t.string :color
      t.string :created_at
      t.string :updated_at

      t.timestamps
    end
  end
end
