class Robot
		GRID_SIZE = 5
		DIRECTIONS = %w[NORTH EAST SOUTH WEST].freeze
		NORTH, EAST, SOUTH, WEST = DIRECTIONS
		COMMANDS = %w[MOVE LEFT RIGHT REPORT PLACE].freeze
		MOVE, LEFT, RIGHT, REPORT, PLACE = COMMANDS

		def initialize
			@x = @y = nil
			@direction = nil
		end

		def place(x, y, direction)
			return unless valid_position?(x, y) && DIRECTIONS.include?(direction)
			@x, @y, @direction = x, y, direction
		end

		def move
			case @direction
				when NORTH then @y += 1 if @y < GRID_SIZE - 1
				when SOUTH then @y -= 1 if @y > 0
				when EAST then @x += 1 if @x < GRID_SIZE - 1
				when WEST then @x -= 1 if @x > 0
			end
		end

		def turn(command)
			i = DIRECTIONS.index(@direction)
			i += (command == RIGHT ? 1 : -1)
			@direction = DIRECTIONS[i % DIRECTIONS.size]
		end

		def report
			"#{@x},#{@y},#{@direction}"
		end

		def invalid?(command)
			return false if (command.include?(PLACE))
			COMMANDS.include?(command) && 
				(@x.nil? || @y.nil? || @direction.nil?)
		end

		def draw_direction
			return "<" if @direction == WEST
			return ">" if @direction == EAST
			return "^" if @direction == NORTH
			return "v" if @direction == SOUTH
		end

		def draw_grid
			row = ''
			drawing = ''
			for i in 0..GRID_SIZE - 1
				for ii in 0..GRID_SIZE
					row += "|#{@x == ii && @y == i ? draw_direction() : ' '}"
				end
				drawing = "#{row}\n#{drawing}"
				row = ''
			end
			return drawing
		end

		private

		def valid_position?(x, y)
			x.between?(0, GRID_SIZE - 1) && y.between?(0, GRID_SIZE - 1)
		end
end

if __FILE__ == $0
	robot = Robot.new

	loop do
		print "Command ('q' to quit) -> "
		command = gets.chomp.strip
		break if command.nil? || command.downcase == 'q'
		if robot.invalid?(command)
			puts 'Invalid command'
			next 
		end
			
		case command
			when /^PLACE\s+(\d+),(\d+)\s+(\w+)$/
				x, y, dir = $1.to_i, $2.to_i, $3
      	robot.place(x, y, dir)
			when 'MOVE' then robot.move
			when 'LEFT', 'RIGHT' then robot.turn(command)
			when 'REPORT' then puts robot.report
			else puts 'Invalid command'
		end

		puts robot.draw_grid
	end
end