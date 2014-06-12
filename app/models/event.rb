class Event < ActiveRecord::Base
  belongs_to :host, source: :user
  has_many :attendees, source: :user
end
