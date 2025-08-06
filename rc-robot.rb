$GRID = 5
$PLACE = 'PLACE'
$VALID_COMMANDS = ['MOVE', 'LEFT', 'RIGHT', 'REPORT']
$MOVE, $LEFT, $RIGHT, $REPORT = $VALID_COMMANDS
$VALID_DIRECTIONS = ['NORTH', 'EAST', 'SOUTH', 'WEST']
$NORTH, $EAST, $SOUTH, $WEST = $VALID_DIRECTIONS
$direction = nil
$position = [nil, nil]

def listen_quit(command)
	if command.downcase() == 'q'
		puts 'Bye bye'
		return true
	end
	false
end
def listen_invalid_command(command)
	if not ($VALID_COMMANDS.include?(command) || command.include?($PLACE))
		puts 'Invalid command. Try again...'
		return true
	end
	false
end
def listen_commands_before_place(command)
	if $VALID_COMMANDS.include?(command) && $direction == nil
		puts 'Invalid command. Try again...'
		return true
	end
	false
end
def listen_invalid_place_command(command)
	begin
		place = command.split(' ')
		raise if place[0] != $PLACE || not $VALID_DIRECTIONS.include?(place[2])
		coordinates = place[1].split(',')
		raise if coordinates.length != 2
		x = Integer(coordinates[0])
		y = Integer(coordinates[1])
		raise if x < 0 || x >= $GRID || y < 0 || y >= $GRID
	rescue
			puts 'Invalid PLACE command'
		return true
	end
	false
end
def set_direction_and_position(command)
	place = command.split(' ')
	coordinates = place[1].split(',')
	x = Integer(coordinates[0])
	y = Integer(coordinates[1])
	$direction = place[2]
	$position[0], $position[1] = x, y
end
def set_direction(command)
	index = $VALID_DIRECTIONS.index($direction)
	index -= 1 if command == $LEFT
	index += 1 if command == $RIGHT
	index = 0 if index >= $VALID_DIRECTIONS.length
	index = $VALID_DIRECTIONS.length - 1 if index < 0
	$direction = $VALID_DIRECTIONS[index]
end
def move_position
	$position[0] += 1 if $direction == $EAST
	$position[0] -= 1 if $direction == $WEST
	$position[1] += 1 if $direction == $NORTH
	$position[1] -= 1 if $direction == $SOUTH
 	if $position[0] < 0 ||  $position[0] >= $GRID || $position[1] < 0 ||  $position[1] >= $GRID
		$position[0] = 0 if $position[0] < 0
		$position[0] = $GRID - 1 if $position[0] >= $GRID
		$position[1] = 0 if $position[1] < 0
		$position[1] = $GRID - 1 if $position[1] >= $GRID
	end
end
def draw_direction
	return "<" if $direction == $WEST
	return ">" if $direction == $EAST
	return "^" if $direction == $NORTH
	return "v" if $direction == $SOUTH
end
def draw_grid
	row = ''
	drawing = ''
	for i in 0..$GRID - 1
		for ii in 0..$GRID
			row += "|#{$position[0] == ii && $position[1] == i ? draw_direction() : ' '}"
		end
		drawing = "#{row}\n#{drawing}"
		row = ''
	end
	puts drawing
end

if __FILE__ == $0
	loop do
		print "Command ('q' to quit) -> "
		command = gets.chomp.strip

		break if listen_quit(command)
		next if listen_invalid_command(command)
		if command.include?($PLACE)
			next if listen_invalid_place_command(command)
			set_direction_and_position(command)
		end
		next if listen_commands_before_place(command)
		move_position() if command == $MOVE
		set_direction(command) if command == $LEFT || command == $RIGHT

		draw_grid()

		puts "Output: #{$position[0]},#{$position[1]} #{$direction}" if command == $REPORT
	end
end