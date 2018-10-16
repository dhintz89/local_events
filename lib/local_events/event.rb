class LocalEvents::Event
  attr_accessor :name, :location, :start_date, :end_date, :description, :page_link, :price, :address, :contact_name, :phone, :email, :event_link
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
    puts
    puts
    puts "Here are the details for #{@name}...".colorize(:yellow)
    puts
    instance_variables.each do |prop|
      if prop != :@page_link && prop != :@location
        puts "#{prop.to_s.sub("@","")}: "
        puts "#{instance_variable_get(prop).intern}"
        puts "----"
      end
    end
    puts "page_link:"
    puts @page_link
  end
  
  
# class methods
  
  def self.create_events(events_list)
    self.clear_all
    unless events_list == []
      events_list.each do |event_hash|
        self.new(event_hash)
      end
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
    puts "Here are your local upcoming events".colorize(:yellow)
    puts "Please select an event to learn more:".colorize(:yellow)
    puts
    self.all.each.with_index(1) do |event,i| 
      puts "#{i}. #{event.name}:"
      puts "From #{event.start_date} Through #{event.end_date} | #{event  location}"
      puts "----"
    end
    puts "**end of list, please make a selection above**".colorize(yellow)
    puts "You may also enter 'main menu' to return to the main menu"  .olorize(:yellow)
    puts "Or you may enter 'exit' to exit the program".colorize(:yellow)
  end
  
end