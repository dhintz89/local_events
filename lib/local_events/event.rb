class LocalEvents::Event
  attr_accessor :name, :location, :start_date, :end_date, :description, :page_link, :price, :address, :phone, :ext_link
  @@all = []
  
  def initialize(event_hash)
    event_hash.each do |key,value|
      self.send("#{key}=", value)
    end
    @@all << self
  end
  
  
# instance methods
  
  # add_properties  - self contructor method to populate remaining info using hash from scraper
  
  
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

  def self.clear_all
    self.all.clear
  end
  
end