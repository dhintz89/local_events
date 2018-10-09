class LocalEvents::Scraper
    @@activity_types = ["this", "is", "a", "test"]
    
    
    
  # class methods
  
    def self.activity_types
      @@activity_types
    end
    
    def self.display_activity_types
      self.activity_types.each.with_index(1) do |type, i|
        puts "#{i}: #{type}"
      end
    end
    
    def self.refresh_activity_types
      @@activity_types.clear
    #scrape list of activity types from site and return in array
      @@activity_types << "walking"
      @@activity_types << "biking"
      @@activity_types << "swimming"
      @@activity_types
    end
    
  end