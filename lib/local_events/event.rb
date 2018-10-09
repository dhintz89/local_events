class LocalEvents::Event
  attr_accessor :name, :location, :start_date, :end_date, :description, :price
  @@all = ["snowboarding", "hiking"]
  
  
#instance methods
  
  
# class methods

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