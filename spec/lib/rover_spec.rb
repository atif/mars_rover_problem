require_relative '../spec_helper'
require_relative '../../lib/plateau'
require_relative '../../lib/rover'

describe Rover do
  let(:file_path){File.join(File.dirname(__FILE__), "../../input.txt")}
  let(:file_contents_arr) {File.read(file_path).split}

  before(:each) do 
    @plateau = Plateau.new(file_contents_arr) 
    @rover = @plateau.rovers_arr.first
  end

  it "navigates a rover with movement instructions" do
    position = @rover.navigate(@plateau.dimensions)
    expect(position).to include(x: 1,y: 3,direction: 'N')
  end
end
