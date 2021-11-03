require_relative './Soccer/LaLiga'
class Cli
	def run
		display_options
	end


	def display_options
		puts"Get upcoming fixtures for your favorite sport(s), favorite team(s), or your favorite soccer league(s)."
		puts"Available sports: Soccer, Formula 1"
		puts"Please select a number:  "
		puts"1. Get upcoming Soccer fixtures by league"
		puts"2. Get upcoming fixture for your favorite team"
		puts"2. Get the next upcoming F1 race weekend dates"
		puts"3. Get fixtures by date for all available sports"

		input = gets.strip
		if(input == "1")
			option_1
		end
	end

	def option_1
		puts "Select a league"
		puts "1. La Liga"
		puts "2. Premier League"
		puts "3. Serie A"
		puts "4. Bundesliga"
		input = gets.strip
		if(input == "1")
			puts"These are the latest fixtures La Liga fixtures for the upcoming week."
			LaLiga.display_latest_fixtures
		end
	end

end
Cli.new.run
