# Set up for the application and database. DO NOT CHANGE. #############################
require "sinatra"                                                                     #
require "sinatra/reloader" if development?                                            #
require "sequel"                                                                      #
require "logger"                                                                      #
require "twilio-ruby"                                                                 #
require "bcrypt"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB ||= Sequel.connect(connection_string)                                              #
DB.loggers << Logger.new($stdout) unless DB.loggers.size > 0                          #
def view(template); erb template.to_sym; end                                          #
use Rack::Session::Cookie, key: 'rack.session', path: '/', secret: 'secret'           #
before { puts; puts "--------------- NEW REQUEST ---------------"; puts }             #
after { puts; }                                                                       #
#######################################################################################

spots_table = DB.from(:spots)
logs_table = DB.from(:logs)
users_table = DB.from(:users)

get "/" do 
    puts spots_table.all
    @spots = spots_table.all.to_a
    view "spots"
end

get "/spots/:id" do
    @spot = spots_table.where(id: params[:id]).to_a[0]
    @logs = logs_table.where(spot_id: @spot[:id])
    @users_table = users_table
    view "spot"
end 

get "/spots/:id/entrys/new" do 
    @spot = spots_table.where(id: params[:id]).to_a[0]
    view "new_entry"
end

get "/spots/:id/entrys/create" do
    @spot = spots_table.where(id: params[:id]).to_a[0]
    logs_table.insert(spot_id: params["id"],
                      user_id: session["user_id"],
                      date: params["date"],
                      conditions: params["conditions"],
                      species: params["species"],
                      quantity: params["quantity"],
                      weight: params["weight"],
                      lure_used: params["lure_used"],
                      time: params["time"],
                      water_temp: params["water_temp"],
                      )
    view "create_entry"
end
