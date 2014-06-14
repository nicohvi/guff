class User < ActiveRecord::Base
  has_many :events
  has_and_belongs_to_many :attended_events, source: :event

  validates_presence_of :username, :email, :avatar
  validate_uniqueness_of :email

end
