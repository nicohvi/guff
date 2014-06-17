class User < ActiveRecord::Base
  has_many :events, dependent: :destroy
  has_and_belongs_to_many :attended_events, class_name: 'Event', foreign_key: 'event_id'
  has_many :authentications, dependent: :destroy

  validates_presence_of :email, :image
  validates_uniqueness_of :email

end
