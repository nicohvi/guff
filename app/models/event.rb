class Event < ActiveRecord::Base
  belongs_to :host, class_name: 'User'
  has_and_belongs_to_many :attendees, class_name: 'User'

  validates_presence_of :host, :begins_at, :ends_at, :name
  validate :time_machine_stopper

  scope :daily, -> {
    where  'events.begins_at >= ? AND events.ends_at <= ?',
            Date.today, Date.today.end_of_day
    }
  scope :weekly, -> {
    where 'events.begins_at >= ? AND events.ends_at <= ?',
            Date.today.beginning_of_week, Date.today.end_of_week.end_of_day
  }

  scope :monthly, -> {
    where 'events.begins_at >= ? AND events.ends_at <= ?',
          Date.today.beginning_of_month, Date.today.end_of_month.end_of_day
  }

  def time_machine_stopper
    if begins_at > ends_at
      errors.add(:begins_at, I18n.t('events.validation_errors.begins_at.after_ends_at'))
    end
    if begins_at < Date.today
      errors.add(:begins_at, I18n.t('events.validation_errors.begins_at.time_traveller'))
    end
  end

end
