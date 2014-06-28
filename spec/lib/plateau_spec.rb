require_relative '../spec_helper'
require_relative '../../lib/plateau'

describe Plateau do
  context "Valid direction and movement instructions" do
    let(:file_path){File.join(File.dirname(__FILE__), "../../input.txt")}
    let(:file_contents_arr) {File.read(file_path).split}

    before(:each) { @plateau = Plateau.new(file_contents_arr) }

    it "initializes a plateau" do
      expect(@plateau).to be_a_kind_of Plateau
    end

    it "sets x/y positions for a plateau" do
      expect(@plateau.dimensions[:x]).to eq 5
      expect(@plateau.dimensions[:y]).to eq 5
    end

    it "sets up rover(s) for a plateau" do
      expect(@plateau.rovers_arr.first.position).to include(x: 1, y: 2, direction: 'N')
      expect(@plateau.rovers_arr.last.position).to include(x: 3, y: 3, direction: 'E')
      expect(@plateau.rovers_arr.length).to eq 2
    end

    it "explores the plateau for each rover" do
      final_rover_positions = @plateau.explore
      expect(final_rover_positions.first).to eq "1 3 N"
      expect(final_rover_positions.last).to eq "5 1 E"
    end
  end

  context "Invalid direction" do
    let(:file_path){File.join(File.dirname(__FILE__), "../fixtures/invalid_direction_input.txt")}
    let(:file_contents_arr) {File.read(file_path).split}

    it "aborts the task with invalid direction error message" do
      expect{Plateau.new(file_contents_arr)}.to raise_error do |e|
        expect(e.class).to eq RuntimeError
        expect(e.message).to eq Messages::INVALID_ROVER_DIRECTION
      end
    end
  end

  context "Invalid movement instructions" do
    let(:file_path){File.join(File.dirname(__FILE__), "../fixtures/invalid_movement_instructions_input.txt")}
    let(:file_contents_arr) {File.read(file_path).split}

    it "aborts the task with invalid movement instructions error message" do
      expect{Plateau.new(file_contents_arr)}.to raise_error do |e|
        expect(e.class).to eq RuntimeError
        expect(e.message).to eq Messages::INVALID_ROVER_MOVEMENT_INSTRUCTIONS
      end
    end
  end
end
