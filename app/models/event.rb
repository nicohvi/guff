class Event < ActiveRecord::Base
  belongs_to :host, class_name: 'User', foreign_key: 'user_id'
  has_and_belongs_to_many :attendees, class_name: 'User', foreign_key: 'user_id'

  validates_presence_of :host, :begins_at, :ends_at, :name

  scope :daily, -> {
    where  'events.begins_at >= ? AND events.ends_at <= ?',
            Date.today.to_datetime, Date.today.end_of_day
    }

end
