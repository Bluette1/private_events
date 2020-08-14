class EventAttendance < ApplicationRecord
  belongs_to :event_attendee
  belongs_to :attended_event
end
