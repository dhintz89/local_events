class LocalEvents::CLI
  
# UI Methods

  def call
    puts "welcome to Local Events"
    LocalEvents::Scraper.refresh_activity_types
    call_menu
    puts "Goodbye."
  end


  def call_menu
    puts "---------------------------"
    puts <<~HEREDOC
      Please enter a command. You may type: 
      'new search' to enter details and search for activities.
      'list results' to list the last search results again.
      'refresh activity types' to receive latest list of activity filters from site.
      'exit' to exit app.
      'help' to display this message again.
    HEREDOC
    menu_selection = gets.strip.downcase
    case menu_selection
    when "new search"
      collect_parameters
    when "list results"
      puts "Function Coming Soon"
      call_menu
    when "refresh activity types"
      LocalEvents::Scraper.refresh_activity_types
      puts "activity filters refreshed"
      call_menu
    when "help"
      call_menu
    else
      unless menu_selection == "exit"
        puts "Nice try! #{menu_selection} is not a valid entry, please select from the list."
        call_menu
      end
    end
  end
  
  # Functionality Methods
  
  
  def collect_parameters
    puts "---------------------------"
    puts "Please enter a city:"
    city = gets.strip
    puts "---------------------------"
    puts "Please enter a state code (2 letter abbreviation):"
    state = gets.strip
    location = "#{city}, #{state}"
    puts "---------------------------"
    puts "Please select desired activity type:"
    LocalEvents::Scraper.display_activity_types
    index = gets.strip.to_i - 1
    activity_type = LocalEvents::Scraper.activity_types[index]
    list = LocalEvents::Scraper.get_results(location, activity_type)
    puts list
  end
  
end