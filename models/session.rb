require_relative('../db/sql_runner')

class Session
  attr_accessor :type, :trainer, :capacity
  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @type = options["type"]
    @trainer = options["trainer"]
    @capacity = options["capacity"].to_i
  end

  def save()
    sql = "INSERT INTO sessions
    (type, trainer, capacity)
    VALUES
    ($1, $2, $3)
    RETURNING id"
    values = [@type, @trainer, @capacity]
    @id = SqlRunner.run(sql, values)[0]["id"].to_i
  end

  def update()
    sql = "UPDATE sessions
    SET (type, trainer, capacity)
    = ($1, $2, $3)
    WHERE id = $4"
    values = [@type, @trainer, @capacity, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM sessions WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def members()
    sql = "SELECT members.* FROM members
    INNER JOIN bookings
    ON bookings.member_id = members.id
    WHERE bookings.session_id = $1"
    values = [@id]
    return  SqlRunner.run(sql, values).map {|member| Member.new(member)}

  end

  def self.all()
    sql = "SELECT * FROM sessions"
    return SqlRunner.run(sql).map {|session| Session.new(session)}
  end

  def self.delete_all()
    sql = "DELETE FROM sessions"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM sessions WHERE id = $1"
    values = [id]
    return Session.new(SqlRunner.run(sql, values)[0])
  end
end
