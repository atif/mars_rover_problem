class Rover
  attr_reader :position

  def initialize(x, y, direction, movements)
    validate_direction(direction)
    validate_movement_instructions(movements)

    @position = {x: x.to_i, y: y.to_i, direction: direction}
    @movement_instructions = movements.split("")
  end

  def navigate(plateau_dimensions)
    until @movement_instructions.empty?
      instruction = @movement_instructions.shift
      case instruction
      when 'L' then rotate_left
      when 'R' then rotate_right
      when 'M' then move_rover(plateau_dimensions[:x], plateau_dimensions[:y])
      end
    end

    @position
  end

  private
  def validate_direction(direction)
    raise(Messages::INVALID_ROVER_DIRECTION) unless direction =~ /^[NSWE]$/
  end

  def validate_movement_instructions(movements)
    raise(Messages::INVALID_ROVER_MOVEMENT_INSTRUCTIONS) unless movements =~ /^[LRM]+$/
  end

  def rotate_left
    @position[:direction] = case @position[:direction]
                            when 'N' then 'W'
                            when 'S' then 'E'
                            when 'W' then 'S'
                            when 'E' then 'N'
                            end
  end

  def rotate_right
    @position[:direction] = case @position[:direction]
                           when 'N' then 'E'
                           when 'S' then 'W'
                           when 'W' then 'N'
                           when 'E' then 'S'
                           end
  end

  def move_rover(plateau_x_position, plateau_y_position)
    move_x_delta, move_y_delta = case @position[:direction]
                                 when 'N' then [0,1]
                                 when 'S' then [0,-1]
                                 when 'W' then [-1,0]
                                 when 'E' then [1,0]
                                 end

    # Check if rover new position is within plateau limits
    if can_move?(move_x_delta, move_y_delta, plateau_x_position, plateau_y_position)
      # Update new x,y positions
      @position[:x], @position[:y] = @position[:x] + move_x_delta, @position[:y] + move_y_delta
    end
  end

  def can_move?(move_x_delta, move_y_delta, plateau_x_position, plateau_y_position)
    new_x_position = @position[:x] + move_x_delta
    new_y_position = @position[:y] + move_y_delta

    valid_x_position = (new_x_position >= 0 && new_x_position <= plateau_x_position)
    valid_y_position = (new_y_position >= 0 && new_y_position <= plateau_y_position)

    valid_x_position && valid_y_position
  end
end
