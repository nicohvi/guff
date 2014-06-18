class User < ActiveRecord::Base
  has_many :events, dependent: :destroy, foreign_key: 'host_id'
  has_and_belongs_to_many :attended_events, class_name: 'Event'
  has_many :authentications, dependent: :destroy

  validates_presence_of :email, :image
  validates_uniqueness_of :email

  def attend(event)
    self.attended_events << event
  end

end
