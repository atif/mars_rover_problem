# Including required classes/modules
require_relative 'lib/plateau'

class NASA
  def initialize(input_file_path)
    # Checking if input file path is valid
    raise(Messages::FILE_NOT_FOUND) if input_file_path.nil? || !File.exists?(input_file_path)

    @file_contents_arr = File.read(input_file_path).split
  end

  def land_squad
   final_rover_positions = Plateau.new(@file_contents_arr).explore
   final_rover_positions.each {|frp| puts frp}
  end
end
