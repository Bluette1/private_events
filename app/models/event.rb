class Event < ApplicationRecord
  belongs_to :creator, foreign_key: :creator_id, class_name: 'User'
  has_many :event_attendances, foreign_key: :attended_event_id
  has_many :attendees, through: :event_attendances, source: :event_attendee

  scope :upcoming, lambda {
    Event.all.find_all do |event|
      event.date >= Date.today
    end
  }
  scope :past, lambda {
                 Event.all.find_all do |event|
                   event.date < Date.today
                 end
               }
end
