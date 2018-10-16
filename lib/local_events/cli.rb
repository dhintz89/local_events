class LocalEvents::CLI
  
#----- Call Method to kick off program

  def call
    puts "Welcome to Local Events".colorize(:light_magenta)
    LocalEvents::Scraper.refresh_activity_types
    main_menu
    puts
    puts
    puts "Thank you for using Local Events, Goodbye.".colorize(:light_magenta)
  end



#----- Main Menu

  def main_menu
#--- Initial Menu Instructions
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
  
#--- Control flow to based on user input
    case menu_selection
    
  #---- launches searching methods
    when "new search"
      LocalEvents::Event.create_events(LocalEvents::Scraper.get_results)
      if LocalEvents::Event.all == []
        puts "No results found, please try a new search".colorize(:red)
        puts "Back to main menu".colorize(:yellow)
        main_menu
      else  
        events_menu
      end
      
  #---- returns values from last search
    when "list results"
      if LocalEvents::Event.all == []
        puts
        puts "No Events Found, type 'new search' to search or make another selection from the menu".colorize(:red)
        main_menu
      else
        events_menu
      end
      
  #---- Re-scrapes list values for activity types
    when "refresh activity types"
      LocalEvents::Scraper.refresh_activity_types
      puts
      puts "activity filters refreshed".colorize(:green)
      main_menu
      
  #---- Displays menu instructions again (not really needed)
    when "help"
      main_menu
      
  #---- Exit or Error Message
    else
      unless menu_selection == "exit"
        puts
        puts "Nice try! #{menu_selection} is not a valid entry, please select from the list.".colorize(:red)
        main_menu
      end
    end
  end
  
  
  
#----- Select Event Menu
  
  def events_menu
    
#--- Displays results from search and accepts input to guide control flow
    LocalEvents::Event.display_events
    menu_selection = gets.strip
    
  #---- Returns to Main Menu
    if menu_selection.downcase == "main menu"
      main_menu
      
  #---- Allows user to choose event and opens Details View
    elsif
      menu_selection.to_i > 0 && menu_selection.to_i <= LocalEvents::Event.all.length
      index = menu_selection.to_i - 1
      chosen_event = LocalEvents::Event.all[index]
      chosen_event.add_properties(LocalEvents::Scraper.scrape_event_details(chosen_event.page_link))
      chosen_event.display_full_event
      main_menu
      
  #---- Exit App or Error Message
    else
      unless menu_selection.downcase == "exit"
        puts
        puts "#{menu_selection} is not a valid selection. Please select an event by number to see more details.".colorize(:red)
        events_menu
      end
    end
  end
  
end