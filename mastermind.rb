require 'sinatra'
enable :sessions

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
  erb :guessagain

end


post '/compareCodes' do
  pass if session[:turn] == 11
  session[:turn] += 1
  array = params.to_a
  @guess = array[0][1]
  puts @guess

  erb :checkanswers

end

post '/compareCodes' do
  erb :loser
end


def playerGuess
  puts "\nPlease give me the first color."
  @guessCode = [color1, color2, color3, color4]
  compareCodes
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




=begin
class Mastermind

def typeOfGame

  puts "If you want to guess the code, enter yes. Enter no, and I'll end the game."
  @answer = gets.downcase.chomp

  if @answer == "yes"
  startGame

  elsif @answer == "no"
    puts "Goodbye!"
    exit
    #userCode
  else puts "Please enter yes or no"
    @answer = gets.downcase.chomp
      if @answer == "yes"
      startGame
      elsif @answer == "no"
      #userCode
      else exit
      end
  end

end

def startGame
  computerCode
  print "\nWelcome to Mastermind! You have 12 chances to guess my color code.
  \nThere are 6 colors you can guess from: red, green, blue, black, white, and brown. Let's begin!\n"
  playerGuess
end

def userCode

  puts "\nPlease give me the first color."
  usercolor1 = gets.chomp
  puts "Please give me the second color."
  usercolor2 = gets.chomp
  puts "Please give me the third color."
  usercolor3 = gets.chomp
  puts "Please give me the fourth color."
  usercolor4 = gets.chomp
  @yourCode = [usercolor1, usercolor2, usercolor3, usercolor4]
  computerGuess
end

def computerGuess
  computerCode
  @results = @colorCode.zip(@yourCode).map { |x, y|
    if x == y
  "Direct match!"
  else
    "-"
  end
  }

  print @results
  print @colorCode
   @newArray = @colorCode.zip(@yourCode).map{|x,y| x == y ? y : x}
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

def playerGuess
  puts "\nPlease give me the first color."
  color1 = gets.chomp
  puts "Please give me the second color."
  color2 = gets.chomp
  puts "Please give me the third color."
  color3 = gets.chomp
  puts "Please give me the fourth color."
  color4 = gets.chomp
  @guessCode = [color1, color2, color3, color4]
  compareCodes
  end

def compareCodes

@results = @colorCode.zip(@guessCode).map { |x, y|
  if x == y
"Direct match!"
else
  "-"
end

}

@hint = (@colorCode & @guessCode).shuffle
print "\nHere's your guess: #{@guessCode}\nHere are how many matches you guessed correctly: #{@results}\nThese colors are definitely somewhere in my code: #{@hint}\n"
turn

if @guessCode == @colorCode
  puts "You win!"
  @win = true
  exit
else
  playerGuess
  end

end

def turn
  #I found an answer on stackoverflow that helped me with this method, but I forget the link.

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

end

a = Mastermind.new
a.typeOfGame
=end
