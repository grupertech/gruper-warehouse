class Event < ApplicationRecord
  attr_accessor :date_range
  
  validates :title, :start_event, :end_event, presence: true

  def all_day_event?
    self.start_event == self.start_event.midnight && self.end_event == self.end_event.midnight ? true : false
  end

  def e_start_event
    self.start_event
  end

  def e_end_event
    self.end_event
  end
end