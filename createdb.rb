# Set up for the application and database. DO NOT CHANGE. #############################
require "sequel"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB = Sequel.connect(connection_string)                                                #
#######################################################################################

# Database schema - this should reflect your domain model
DB.create_table! :spots do
    primary_key :id
    String :name
    String :location, text: true
    String :where_to, text: true
    String :successful_tactics
end
DB.create_table! :logs do
    primary_key :id
    foreign_key :spot_id
    foreign_key :user_id
    String :name            ##remove once login capability exists
    String :date
    String :conditions 
    String :species
    String :quantity
    String :weight
    String :lure_used
    String :time
    String :water_temp
end
DB.create_table! :users do
    primary_key :id
    String :name
    String :email
    String :password
end 


# Insert initial (seed) data
spots_table = DB.from(:spots)

spots_table.insert(name: "The Point", 
                    location: "Located on the West edge of Beach 3, the point extends as a mini peninsula into the lake. On the edge of the point you will find a large flag pole and jungle gym. When walking down the road towards the point, you will see 'The Cove' to the right of the point and at your 7 oclock will be 'Back Bay'. These are sub-locations within 'The Point'.",
                    where_to: "Ironically, fishing is never the best from the actual 'point'. The best fishing is along the shoreline of the cove using whacky rig, texas rig plastics, and buzz baits at night. To the far right of the cove is 'The Ledge'. Texas rigged plastics, particularly creature baits work best around 'The Ledge', particulartly off the rocks.",
                    successful_tactics: "Texas Rigged - Soft Plastics")

spots_table.insert(name: "Islands", 
                    location: "Located onthe South end of the Lake Holiday, the islands are 3 protruding land masses that separate the main lake from 'Beach 2' swim area.",
                    where_to: "Driving your boat South towards the dam, park your boat in between island 1 and 2 and in between 2 & 3 and cast both off of the points of the islands, 1' - 5' from shore. Cranks, jigs, whacky rig are successful. Be sure to hit the overhanging tree off of island 2, guaranteed smallie first cast.",
                    successful_tactics: "Jigs")

spots_table.insert(name: "Uncle Mike's Cove", 
                    location: "Driving South towards the dam, Uncle Mike's Cove is the last of the 3 finger inlets off of the main lake. Steep wooded area is on the right as you enter the cove.",
                    where_to: "Steep rocks on the right as you enter the inlet. Cranks across the point of inlet as well as jigs. Work slow and look out for snags",
                    successful_tactics: "Jigs")

spots_table.insert(name: "224", 
                    location: "As the name implies, located at lot 224. Can be found across the lake (West) of island 2. Look for large red '224' sign, can't miss it.",
                    where_to: "Cast towards the rotting wood dock as well as the rocks to the right. It drops swiftly but on a hot summer day, bass find comfort in the shade beneath the dock. To the left of the dock is a long stretch of steep rocks that produce as well. Similar to Uncle Mike's Cove. Jigs, cranks, Ned Rig will produce.",
                    successful_tactics: "Ned Rig")

spots_table.insert(name: "Dam", 
                    location: "Southern most point of the lake. Water spills over into the basin below. Can't miss it. If you do, this will be the last time you read this. ",
                    where_to: "The Dam is flanked on both sides by large boulders on shore and beneath the surface. Throwing cranks off of the points of the rocks that flank the spillover shooting fish in a barrel on good days. By afternoon when the water is pressurized or if there's no wind and clear, don't bother.",
                    successful_tactics: "DT-6 crank")

spots_table.insert(name: "Shadow Shore", 
                    location: "Standing on the beach at Beach 1 and looking South, it's directly across the lake at your 2 oclock. It gets its name from greenery that pops up inbetween the rows of houses so look for trees and shrubbery. There is only 1 home between Shadow Shore and the start of Beach 2. Provides needed shade on hot summer days.",
                    where_to: "Cast toward the pontoon shore station and overhanging tree. It is a great nook where bass spawned in late 2019. Closer towards Beach 2 throw ned rig/jig 3' to 10' off shore for smallmouth",
                    successful_tactics: "Ned Jigs")
