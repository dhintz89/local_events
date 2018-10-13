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
      LocalEvents::Event.create_events(LocalEvents::Scraper.get_results)
      puts LocalEvents::Event.all.map {|i| i.name}
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
  
  
  
  
end