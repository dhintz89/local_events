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
      display_events
    when "list results"
      if LocalEvents::Event.all == []
        puts "No Events Found, type 'new search' to search or make another selection from the menu"
        main_menu
      else
        display_events
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
  
  def display_events
    puts
    puts "Here are your local upcoming events"
    puts "Please select an event to learn more:"
    puts
    LocalEvents::Event.all.each.with_index(1) do |event,i| 
      puts "#{i}. #{event.name}:"
      puts "From #{event.start_date} Through #{event.end_date} | #{event.location}"
      puts "----"
    end
    puts "**end of list, please make a selection above**"
  end
  
  
  
end