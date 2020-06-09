# Set up for the application and database. DO NOT CHANGE. #############################
require "sequel"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB = Sequel.connect(connection_string)                                                #
#######################################################################################

# Database schema - this should reflect your domain model
DB.create_table! :restaurants do
  primary_key :id
  String :name
  String :description, text: true
  String :cuisine
  String :location
end
DB.create_table! :reviews do
  primary_key :id
  foreign_key :restaurant_id
  foreign_key :user_id
  Boolean :recommend
  String :comments, text: true
end
DB.create_table! :users do
  primary_key :id
  String :name
  String :email
  String :password
  String :city
end

# Insert initial (seed) data
restaurants_table = DB.from(:restaurants)

restaurants_table.insert(name: "Pizzaiolo", 
                        description: "A blend of fresh California and classic Italy, this restuarant takes wood-fired pizza and pastas to a whole new level",
                        cuisine: "Italian",
                        location: "5008 Telegraph Ave, Oakland, CA 94609")

restaurants_table.insert(name: "Rintaro", 
                        description: "A Japanese izakaya that has flavorful takes of traditional menu items",
                        cuisine: "Japanese",
                        location: "82 14th St, San Francisco, CA 94103")

restaurants_table.insert(name: "The Cheeseboard Pizza", 
                    description: "Serving one flavor of pizza a day with a farm-to table focus, these thin crust, artisan pizzas will never disappoint",
                    cuisine: "New American",
                    location: "1512 Shattuck Ave, Berkeley, CA 94709")
