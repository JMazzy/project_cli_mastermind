class Peg
  COLORS = [ "yellow", "green", "purple", "orange", "blue", "brown"]
  attr_accessor :color
  def initialize (color)
    @color = color
  end
end

class Row 

  attr_accessor :slots
  def initialize
    @slots = []
  end

  def populate_row ( colors )
    colors.each do | color |
      @slots << Peg.new( color )
    end
  end

  def to_s
    colors = @slots.map { |slot| slot.color }
    colors.join(", ")
  end

end

class Board
  attr_accessor :solution_row, :guesses
  def initialize
    @solution_row = Row.new
    @guesses = []
  end

  def create_solution ( solution )
    @solution_row.populate_row ( solution )
  end

  def create_autogenerate_solution 
    solution = []
    4.times do
      solution << Peg::COLORS.sample
    end
    create_solution( solution )
  end

  def add_guess_row( guess )
    guess_row = Row.new
    guess_row.populate_row(guess)
    @guesses << guess_row
  end
end

class Player
  def make_a_guess
    puts "What is your guess?"
    guess = gets.chomp.split(",")
    guess.each{ |color| color.strip! }
    guess
  end
end

class Human < Player
  def make_a_guess
    puts "What is your guess?"
    guess = gets.chomp.split(",")
    guess.each{ |color| color.strip! }
    guess
  end
end

class Computer < Player
  def make_a_guess
  end
end


class Mastermind

  def initialize
    @board = Board.new
    @master = Player.new
    @guesser = Player.new
  end

  def instructions
    puts "make a guess"
    puts "if incorrect, make another"
  end

  def play
    instructions



    @board.add_guess_row(@guesser.make_a_guess)
  end

  def check_win?
    @board.guesses.last == @board.solution_row
  end

  def respond_to_guess
    guess = @board.guesses.last
    solution = @board.solution_row
    response = []
    remainder_guess = {}
    remainder_solution = {}

    (0..3).each do |index|
      if guess[index] == solution[index]
        response << "full match"
      else
        guess_color = guess[index].color
        solution_color = solution[index].color

        if remainder_guess.keys.include?(guess_color)
          remainder_guess[guess_color] += 1
        else
          remainder_guess[guess_color] = 1
        end

        if remainder_solution.keys.include?(solution_color)
          remainder_solution[solution_color] += 1
        else
          remainder_solution[solution_color] = 1
        end
      end
    end

    remainder_guess.each do |color, number|
      if remainder_solution.keys.include?(color)
        color_matches = [remainder_solution[color], remainder_guess[color]].min
        color_matches.times do
          response << "color match"
        end
      end
    end

    response
  end
end

test_game = Mastermind.new
test_board = Board.new
test_board.create_autogenerate_solution()
puts test_board.solution_row.to_s
test_board.add_guess_row(Row.new.populate_row(["yellow", "blue", "orange", "green"]))
puts test_board.guesses.last.to_s

# the_mind = Mastermind.new
# the_mind.play


