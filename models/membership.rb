require_relative('../db/sql_runner')

class Membership
  attr_accessor :type, :start_hour, :end_hour
  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @type = options["type"]
    # 24hour clock is used
    @start_hour = options["start_hour"].to_i
    @end_hour = options["end_hour"].to_i
  end

  def save()
    sql = "INSERT INTO memberships
    (type, start_hour, end_hour)
    VALUES
    ($1, $2, $3)
    RETURNING id"
    values = [@type, @start_hour, @end_hour]
    @id = SqlRunner.run(sql, values)[0]["id"].to_i
  end

  def update()
    sql = "UPDATE memberships
    SET (type, start_hour, end_hour)
    = ($1, $2, $3)
    WHERE id = $4"
    values = [@type, @start_hour, @end_hour, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM memberships WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM memberships"
    return SqlRunner.run(sql).map {|membership| Membership.new(membership)}
  end

  def self.delete_all()
    sql = "DELETE FROM memberships"
    SqlRunner.run(sql)
  end
end
