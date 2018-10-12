class LocalEvents::Scraper
  attr_accessor :location, :activity_type
  @@activity_types = []
    
  def initialize(location, activity_type)
    @location = location
    @activity_type = activity_type
  end
    
# instance methods

# Search will enter the parameters into web form fields using Watir and return url for results
# Watir doesn't work because Ruby can't find chromedriver file (might be due to Learn being remote IRB - not reading my hard drive)
  def search(location='Denver, CO', activity_type='All')
    if location == 'Denver, CO'
      "https://www.eventsnearhere.com/find-events/co/denver/All/All/events"
    elsif location == 'Myrtle Beach, SC'
      "https://www.eventsnearhere.com/find-events/sc/myrtle-beach/All/All/events?miles=70"
    end
  #   once I fix Watir
    # browser = Watir::Browser.new :chrome
    # browser.goto "https://www.eventsnearhere.com/"
    # browser.text_field(id: 'inputString').set @location
    # browser.select_list(id: 'landuse').select_value @activity_type
    # browser.button(class: 'btn btn-warning').click
    # puts browser.url
    # browser.close
  end
  
  
  
    
# class methods
  def self.get_page(url)
    Nokogiri::HTML(open(url))
  end
  
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
    landing_page = self.get_page("https://www.eventsnearhere.com/")
    landing_page.css("div.event-copy-box div.form-group:nth-child(2) option[value]").each {|cat| @@activity_types << cat.text}
    @@activity_types
  end
    
end