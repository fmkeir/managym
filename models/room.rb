require_relative('../db/sql_runner')

class Room
  attr_accessor :name, :capacity
  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
    @capacity = options["capacity"]
  end

  def save()
    sql = "INSERT INTO rooms
    (name, capacity)
    VALUES
    ($1, $2)
    RETURNING id"
    values = [@name, @capacity]
    @id = SqlRunner.run(sql, values)[0]["id"].to_i
  end

  def update()
    sql = "UPDATE rooms
    SET (name, capacity)
    = ($1, $2)
    WHERE id = $3"
    values = [@name, @capacity, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM rooms WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM rooms"
    return SqlRunner.run(sql).map {|room| Room.new(room)}
  end

  def self.delete_all()
    sql = "DELETE FROM rooms"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM rooms WHERE id = $1"
    values = [id]
    return Room.new(SqlRunner.run(sql, values)[0])
  end
end
