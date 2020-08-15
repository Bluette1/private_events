class User < ApplicationRecord
  has_many :created_events, foreign_key: "creator_id", class_name: "Event"
  has_many :event_attendances, foreign_key: :event_attendee_id
  has_many :attended_events, through: :event_attendances

def upcoming_events
  upcoming_events = []
  self.attended_events.collect do |event|
    upcoming_events << event if event.date >= Date.today
  end
  upcoming_events
end

def previous_events
  previous_events = []
  self.attended_events.collect do |event|
    previous_events << event if event.date < Date.today
  end
  previous_events
end

end
