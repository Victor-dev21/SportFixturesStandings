require 'uri'
require 'net/http'
require 'openssl'
require 'json'
require 'date'
class SoccerApi
	#url = URI("https://api-football-v1.p.rapidapi.com/v3/fixtures?date=2021-10-31&league=140&season=2021")
	@@fixtures

	def self.establish_connection(url)
		path = ENV['SOCCER_API']
		api_key = File.open(path).read
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		request = Net::HTTP::Get.new(url)
		request["x-rapidapi-host"] = 'api-football-v1.p.rapidapi.com'
		request["x-rapidapi-key"] = api_key
		response = http.request(request)


	end
	# date parameter format: "yyyy-month-day_of_month"
	def self.fixtures(date,league_id)
		current_season = Date.today.year
		url = URI("https://api-football-v1.p.rapidapi.com/v3/fixtures?date=#{date}&league=#{league_id}&season=#{current_season}")
		@@fixtures = url
	end
	# date parameter format: "yyyy-month-day_of_month"
	# only from top four european leagues
	def self.display_all_matches_for_a_specific_date(date)
		top_leagues=[140,78,39,135]
		top_leagues.each do |league_id|
		self.fixtures(date,league_id)
		self.create_matches_from_collection(@@fixtures)
		end
	end

	def self.display_matches_for_a_specific_fixture(fixture)
		response = SoccerApi.establish_connection(fixture)
		if(response['response'].length > 0 && response['response'][0] != nil)
		puts response['response'][0]['league']['name']
		response['response'].each do |team|
			puts"#{team['teams']['home']['name']} vs #{team['teams']['away']['name']}"
		end
	end
		puts
	end

	def self.print_easy_to_read_json(response)
		response = JSON.parse(response.body.gsub("=>", ":").gsub(":nil,", ":null,"))
		puts JSON.pretty_generate(response)
	end
end

#response = SoccerApi.establish_connection(SoccerApi.fixtures("2021-10-31","140"))
SoccerApi.display_all_matches_for_a_specific_date("2021-11-06")

#puts JSON.pretty_generate(response['response'][2]['teams']['home']['name'])
#puts JSON.pretty_generate(response['response'][2]['teams']['away']['name'])
