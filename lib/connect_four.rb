class Token
  attr_accessor :value, :colour

  def initialize (value, colour = nil)
    @value = value
    @colour = colour
  end

  def assign_colour(turn)
    @colour = turn
    @colour
  end

end

class Board
  attr_accessor :board

    def initialize()
        @board = create_board
    end

    def create_board
        grid = Array.new(6) { Array.new(7) }
        (0...6).each do |row|
          (0...7).each do |col|
            grid[row][col] = Token.new([row, col])
          end
        end
        grid
    end

    def find_node(value)
      (0...6).each do |row|
        (0...7).each do |col|
          return @board[row][col] if @board[row][col].value == value
        end
      end
      nil # Return nil if the node is not found
    end

    def add(location, turn)
      token = find_node(location)
      return "not valid location" if token.nil?
      return nil if token.colour

      if token_below(location) == false
        return nil
      end


      token.assign_colour(turn)
      token
    end

    def display_board
      @board.reverse.each do |row|
        row.each do |token|
          print token.colour ? token.colour[0].upcase : "."
          print " "
        end
        puts
      end
    end

    def token_below(location)
      if location[0] == 0
        return true
      elsif @board[location[0] - 1][location[1]].colour.nil?
        return false
      end
    end
end

def get_location
  puts "Enter row and column (e.g., 3 2):"
  gets.chomp.split.map(&:to_i)
end


def add_blue(board)
  location = get_location
  if board.add(location, "blue").nil?
    puts "Location occupied or invalid. Try again."
    add_blue(board)
  end
end


def add_red(board)
  location = get_location
  if board.add(location, "red").nil?
    puts "Location occupied or invalid. Try again."
    add_red(board)
  end
end

b = Board.new()

t = 0
while t < 48
  #code below adds a token to the desired location

  # need to add a way to check if location is already occupied
  if t % 2 == 0
    add_blue(b)
  else
    add_red(b)
  end

  b.display_board
  #add way to check for win


  t += 1
end




# also need to add tests to ensure that the protgram works as intended and to also fulfil the requirenments of the exercise fot the odin project
