class LocalEvents::CLI
  
  def call
    puts "welcome to Local Events"
    puts LocalEvents::Event.all
    puts "Goodbye"
  end
  
  
# will want a menu to include 'exit' 'help' 'list again'
end