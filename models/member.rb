require_relative('../db/sql_runner')

class Member
  attr_accessor :membership_id, :first_name, :last_name, :goal
  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @membership_id = options["membership_id"]
    @first_name = options["first_name"]
    @last_name = options["last_name"]
    @goal = options["goal"]
  end

  def full_name()
    return "#{@first_name} #{@last_name}"
  end

  def formal_name()
    return "#{@first_name[0]}. #{@last_name}"
  end

  def can_attend?(session)
    session_time = session.start_time_decimal
    session_length = session.duration.to_f/60
    can_book_from = membership().start_time_decimal
    can_book_to = membership().end_time_decimal

    start_time_allowed = session_time > can_book_from
    end_time_allowed = (session_time + session_length) < can_book_to

    return  start_time_allowed && end_time_allowed
  end

  def save()
    sql = "INSERT INTO members
    (membership_id, first_name, last_name, goal)
    VALUES
    ($1, $2, $3, $4)
    RETURNING id"
    values = [@membership_id, @first_name, @last_name, @goal]
    @id = SqlRunner.run(sql, values)[0]["id"].to_i
  end

  def update()
    sql = "UPDATE members
    SET (membership_id, first_name, last_name, goal)
    = ($1, $2, $3, $4)
    WHERE id = $5"
    values = [@membership_id, @first_name, @last_name, @goal, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM members WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def membership_type()
    sql = "SELECT type FROM memberships WHERE id = $1"
    values = [@membership_id]
    return SqlRunner.run(sql, values)[0]["type"]
  end

  def membership()
    sql = "SELECT * FROM memberships WHERE id = $1"
    values = [@membership_id]
    return Membership.new(SqlRunner.run(sql, values)[0])
  end

  def self.all()
    sql = "SELECT * FROM members"
    return SqlRunner.run(sql).map {|member| Member.new(member)}
  end

  def self.delete_all()
    sql = "DELETE FROM members"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM members WHERE id = $1"
    values = [id]
    return Member.new(SqlRunner.run(sql, values)[0])
  end
end
