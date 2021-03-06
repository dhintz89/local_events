class LocalEvents::Event
  attr_accessor :name, :location, :start_date, :end_date, :description, :page_link, :price, :address, :contact_name, :phone, :email, :event_link
  @@all = []
  
  # Self-creates an instance based upon the values in the event_hash passed in when create_events method calls this
  
  def initialize(event_hash)
    event_hash.each do |key,value|
      self.send("#{key}=", value)
    end
    @@all << self
  end
  
  
# instance methods
  
  # Adds details to the selected event
  def add_properties(event_details_hash)
    event_details_hash.each do |key, value|
      self.send("#{key}=", value)
    end
  end
  
# class methods
  
  def self.all
    @@all
  end

  def self.clear_all
    self.all.clear
  end
  
  # Self-creates event instances based on array of event hashes
  # Calls upon initialize and passes in one hash at a time
  def self.create_events(events_list)
    self.clear_all
    unless events_list == []
      events_list.each do |event_hash|
        self.new(event_hash)
      end
    end
  end
  
end