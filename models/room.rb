require_relative('../db/sql_runner')

class Room
  attr_accessor :name, :capacity
  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
    @capacity = options["capacity"]
  end
end
