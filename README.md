# Remote Control Robot

## Instructions

- Prerequisite: ruby
- Run the application by entering `ruby rc-robot.rb`
- Run the test by entering `ruby rc-robot-test.rb`
- Start by using the `PLACE` command, `PLACE X,Y FACE`
  - example: `PLACE 0,0 NORTH`
  - X,Y are numbers from 0 to 4 only
  - FACE are directions from these choices
    - NORTH
    - SOUTH
    - EAST
    - WEST
- You can now use these commands after:
  - `MOVE`
  - `LEFT`
  - `RIGHT`
  - `PLACE ...`
  - `REPORT`
  - `Q` / `q`
- `MOVE` moves the robot in the direction it is facing
- `LEFT` turns the robot 90 degrees to the left
- `RIGHT` turns the robot 90 degrees to the right
- `PLACE ...` is described in the first command. You execute the command again to move the robot in a different place
- `REPORT` shows a message of the current coordinates of the robot and direction its facing
- `Q` or `q` ends the application
- The application shows a drawn out grid with the robot facing the commanded direction in the commanded place
- The robot cannot go outside the 0 to 4 coordinates, commands that do so will be ignored
- Commands that are entered and not followed exactly will be ignored. A message will display that mentions the invalid command.

### Log

- Started at 1PM PST
- Completed at 5PM PST
- Make instructions in readme
- Start making tests at 5:45PM PST
- Test coordinates outside 0 - 4 range

### Notes

- I was not able to create a git repository before making this console application
- I started around 1PM PST and finished the app by 5PM PST. It was not a straight coding session because I was multitasking my work and making this app
