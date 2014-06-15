class User < ActiveRecord::Base
  has_many :events
  has_and_belongs_to_many :attended_events, source: :event

  validates_presence_of :username, :email, :avatar
  validates_uniqueness_of :email

  def self.from_provider(auth_hash)
    self.find_by(email: options[:email])
  end

end
