class CreateEventAttendances < ActiveRecord::Migration[5.1]
  def change
    create_table :event_attendances do |t|
      t.references :event_attendee, foreign_key: { to_table: 'users' }
      t.references :attended_event, foreign_key: { to_table: 'events' }

      t.timestamps
    end
  end
end
