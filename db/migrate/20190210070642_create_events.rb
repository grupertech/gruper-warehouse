class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.date :start_event
      t.date :end_event
      t.string :color
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
  end
end
