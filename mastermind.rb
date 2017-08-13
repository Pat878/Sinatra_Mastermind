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
  pass if session[:turn] == 5
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

end
