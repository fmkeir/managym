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

  def member()
    sql = "SELECT * FROM members WHERE id = $1"
    values = [@member_id]
    return Member.new(SqlRunner.run(sql, values)[0])
  end

  def session()
    sql = "SELECT * FROM sessions WHERE id = $1"
    values = [@session_id]
    return Session.new(SqlRunner.run(sql, values)[0])
  end

  def self.create(member, session)
    if session.members_includes?(member)
      return "This member is already signed up to this session."
    elsif !member.can_attend?(session)
      return "This member's membership isn't valid for the class. Please try another timeslot."
    elsif !session.enough_space?()
      return "This class is already full. Please try to book for another class."
    else
      Booking.new({"member_id" => member.id, "session_id" => session.id}).save()
      return "Done"
    end
  end

  def self.all()
    sql = "SELECT * FROM bookings ORDER BY id DESC"
    return SqlRunner.run(sql).map {|booking| Booking.new(booking)}
  end

  def self.count()
    sql = "SELECT count(*) FROM bookings"
    return SqlRunner.run(sql)[0]["count"].to_i
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
