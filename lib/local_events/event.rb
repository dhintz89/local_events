class LocalEvents::Event
  attr_accessor :name, :location, :start_date, :end_date, :description, :page_link, :price, :address, :contact_name, :phone, :email, :ext_link
  @@all = []
  
  def initialize(event_hash)
    event_hash.each do |key,value|
      self.send("#{key}=", value)
    end
    @@all << self
  end
  
  
# instance methods
  
  def add_properties(event_details_hash)
    event_details_hash.each do |key, value|
      self.send("#{key}=", value)
    end
  end
  
  def display_full_event
    instance_variables.each do |prop|
      puts "#{prop.to_s.sub("@","")}: "
      puts "#{instance_variable_get(prop).intern}"
    end
  end
  
  
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
  
  def self.display_events
    puts
    puts "Here are your local upcoming events"
    puts "Please select an event to learn more:"
    puts
    self.all.each.with_index(1) do |event,i| 
      puts "#{i}. #{event.name}:"
      puts "From #{event.start_date} Through #{event.end_date} | #{event.location}"
      puts "----"
    end
    puts "**end of list, please make a selection above**"
  end
  
end