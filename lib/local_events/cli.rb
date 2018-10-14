class LocalEvents::CLI
  
#----- UI Methods

  def call
    puts "welcome to Local Events"
    LocalEvents::Scraper.refresh_activity_types
    main_menu
    puts
    puts
    puts "Thank You, Come Again!"
  end


  def main_menu
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
      events_menu
    when "list results"
      if LocalEvents::Event.all == []
        puts "No Events Found, type 'new search' to search or make another selection from the menu"
        main_menu
      else
        events_menu
      end
    when "refresh activity types"
      LocalEvents::Scraper.refresh_activity_types
      puts "activity filters refreshed"
      main_menu
    when "help"
      main_menu
    else
      unless menu_selection == "exit"
        puts "Nice try! #{menu_selection} is not a valid entry, please select from the list."
        main_menu
      end
    end
  end
  
#----- Functionality Methods
  
  def events_menu
    LocalEvents::Event.display_events
    menu_selection = gets.strip
    if menu_selection.to_i > 0 && menu_selection.to_i <= LocalEvents::Event.all.length
      index = gets.strip.to_i - 1
    else
      puts "Not a valid selection. Please select an event by number to see more details."
      events_menu
    end
    chosen_event = LocalEvents::Event.all[index]
    chosen_event.add_properties(LocalEvents::Scraper.scrape_event_details(chosen_event.page_link))
    chosen_event.display_full_event
  end
  
end