require 'sinatra'
enable :sessions

get '/' do
  computerCode
  turn
  session[:turn] = @i
  puts @colorCode
  session[:code] = @colorCode
  erb :index

end

get '/guessAgain' do
  puts session[:code]
  erb :index

end


post '/compareCodes' do
  pass if session[:turn] == 11
  session[:turn] += 1
  array = params.to_a
  @guess = array[0][1]
  puts @guess
  if session[:code] == @guess
    redirect '/winner'
  end
  compareCodes
  erb :checkanswers

end

post '/compareCodes' do
  erb :loser
end

get '/winner' do
  erb :winner
end


def computerCode
  # red = 1, green = 2, blue = 3, black = 4, white = 5, brown = 6
@code = Array.new(4) {rand(1..6)}

@colorCode = @code.map { |x|
  if x == 1
  "red"
elsif x == 2
  "green"
elsif x == 3
  "blue"
elsif x == 4
  "black"
elsif x == 5
  "white"
elsif x == 6
  "brown"
#else x
  end
}

end

def turn

    @i ||= -1
    @i += 1

    if @win != true
    print "You have #{11-@i} guesses left!\n"
    end

    if @i == 11
    print "Game over!\nHere's my code: #{@colorCode}"
    exit
    end

  end

  def compareCodes

  @results = session[:code].zip(@guess).map { |x, y|
    if x == y
  "Direct match!"
  else
    "-"
  end

  }

  @hint = (session[:code] & @guess).shuffle
  print "\nHere's your guess: #{@guess}\nHere are how many matches you guessed correctly: #{@results}\nThese colors are definitely somewhere in my code: #{@hint}\n"
  turn

  end
