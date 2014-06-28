# Including required classes/modules
require_relative 'rover'

class Plateau
  attr_reader :dimensions, :rovers_arr

  def initialize(file_contents_arr)
    @dimensions = {}
    @rovers_arr = []

    @dimensions[:x], @dimensions[:y] = file_contents_arr.shift(2).map(&:to_i)
    
    create_rovers(file_contents_arr)
  end

  def explore
    rover_final_positions = []
    @rovers_arr.each do |rov|
      rover_final_positions << rov.navigate(@dimensions).values.join(" ")
    end

    rover_final_positions
  end

  private
  def create_rovers(file_contents_arr)
    @rovers_arr << Rover.new(*file_contents_arr.shift(4)) until file_contents_arr.empty?
  end
end
