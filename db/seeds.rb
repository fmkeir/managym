require('pry')
require_relative('../models/member')
require_relative('../models/session')
require_relative('../models/booking')

Member.delete_all()
Session.delete_all()

member1 = Member.new({
  "first_name" => "Graham",
  "last_name" => "Grahamson",
  "goal" => "Get stronger"
  })
member2 = Member.new({
  "first_name" => "Nil",
  "last_name" => "Nilson",
  "goal" => "Get faster"
  })
member1.save()
member2.save()

session1 = Session.new({
  "type" => "Graham",
  "trainer" => "George Smith",
  "capacity" => 5
  })
session2 = Session.new({
  "type" => "Nil",
  "trainer" => "Nicole Greene",
  "capacity" => 30
  })
session1.save()
session2.save()

booking1 = Booking.new({
  "member_id" => member1.id,
  "session_id" => session2.id
  })
booking2 = Booking.new({
  "member_id" => member2.id,
  "session_id" => session2.id
  })
booking1.save()
booking2.save()

binding.pry
nil
