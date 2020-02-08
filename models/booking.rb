require_relative('../db/sql_runner')

class Booking
  attr_reader :id, :member_id, :session_id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @member_id = options["member_id"].to_i
    @session_id = options["session_id"].to_i
  end

  def save()
    sql = "INSERT INTO bookings
    (member_id, session_id)
    VALUES
    ($1, $2)
    RETURNING id"
    values = [@member_id, @session_id]
    @id = SqlRunner.run(sql, values)[0]["id"].to_i
  end

  def delete()
    sql = "DELETE FROM bookings WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM bookings"
    return SqlRunner.run(sql).map {|booking| Booking.new(booking)}
  end

  def self.delete_all()
    sql = "DELETE FROM bookings"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM bookings WHERE id = $1"
    values = [id]
    return Booking.new(SqlRunner.run(sql, values)[0])
  end
end
