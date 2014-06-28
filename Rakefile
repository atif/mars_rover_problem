require_relative 'nasa'
require_relative 'util/messages'
include Messages

namespace :nasa do
  task :land_squad do
    NASA.new(ENV['FILE']).land_squad
  end
end
