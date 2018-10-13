class LocalEvents::Event
  attr_accessor :name, :location, :start_date, :end_date, :description, :price, :link
  @@all = []
  
  def initialize(event_hash)
    event_hash.each do |key,value|
      self.send("#{key}=", value)
    end
    @@all << self
  end
  
  
#instance methods
  
  
# class methods
  
  def self.create_events(events_list)
    events_list.each do |event_hash|
      self.new(event_hash)
    end
  end

  def self.save
    @@all << self
  end  
  
  def self.all
    @@all
  end

  def clear_all
    self.all.clear
  end
  
end