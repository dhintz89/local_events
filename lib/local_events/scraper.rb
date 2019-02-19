class LocalEvents::Scraper
  @@activity_types = []

# Universal Methods

  def self.get_page(url)
    Nokogiri::HTML(open(url))
  end
  
  
  # Methods to manage Activity Type List for Main Menu  

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
    @@activity_types.shift
  end
  

  # Methods for searching and returning results for Event creation
  
  def self.collect_parameters
    puts "---------------------------"
    puts "Please enter a city:".colorize(:yellow)
    city = gets.strip
    puts "---------------------------"
    puts "Please enter a state code (2 letter abbreviation):".colorize(:yellow)
    state = gets.strip
    puts "---------------------------"
    puts "Please select desired activity type:".colorize(:yellow)
    display_activity_types
    index = gets.strip.to_i - 1
    activity_type = activity_types[index]
    param = [city, state, activity_type]
  end
  
  
  # Search will interpolate the parameters into web url
  def self.search(parameters)
    "https://www.eventsnearhere.com/find-events/#{parameters[1]}/#{parameters[0]}/#{parameters[2]}/All/events"
  end
  
  def self.get_results
    results_page = search(collect_parameters)
    events_list = []
    unless results_page == nil
      event_record = get_page(results_page).css("div.event_count.basic-event")
      event_record.each do |record|
        events_list << {
          :name => record.css("h2 a span[itemprop~='name']").text,
          :start_date => record.css("div.event-location em time[itemprop~='startDate']").text,
          :end_date => record.css("div.event-location em time[itemprop~='endDate']").text,
          :location => record.css("div.event-location span span[itemprop~='address']").text.strip,
          :page_link => "https://www.eventsnearhere.com" + record.css("h2 a").attribute("href").value
        }
      end
    end
    events_list
  end

  # Method for scraping individual event page for details

  def self.scrape_event_details(page_link)
    page = get_page(page_link)
    event_details_hash = {
      :address => page.css("div#description_list_left span.address_date span[itemprop='address']").text.strip,
      :contact_name => page.css("div#photocalholder div div.textleft").children[3].text.strip,
      :phone => page.css("div#photocalholder div div.textleft").children[8].text.strip,
      :email => page.css("div#photocalholder div div.textleft").children[14].text.strip,
      :description => page.css("div#description_list_left span[itemprop='description'] p").text.strip
    }
    if page.css("span[itemprop='description'] a").text != ""
      event_details_hash[:event_link] = page.css("span[itemprop='description'] a").attribute("href").value.strip
    else
      event_details_hash[:event_link] = "No event link posted."
    end
    event_details_hash
  end
    
end