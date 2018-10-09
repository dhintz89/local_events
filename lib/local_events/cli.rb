class LocalEvents::CLI
  
  def call
    puts "welcome to Local Events"
    # will eventually start with LocalEvents::Scraper.refresh_activity_types
    collect_parameters
    puts "Goodbye"
  end
  
  def collect_parameters
    puts "Please enter a city:"
    city = gets.strip
    puts "Please enter a state code (2 letter abbreviation):"
    state = gets.strip
    puts "Please select desired activity type:"
    LocalEvents::Scraper.display_activity_types
    index = gets.strip.to_i - 1
    binding.pry
    activity_type = LocalEvents::Scraper.activity_types[index]
    LocalEvents::Scraper.new(city, state, activity_type)
  end
  
# will want a menu to include 'exit' 'help' 'list again' 'refresh activity types'
end