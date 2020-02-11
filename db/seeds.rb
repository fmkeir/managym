require('pry')
require_relative('../models/member')
require_relative('../models/session')
require_relative('../models/booking')
require_relative('../models/room')
require_relative('../models/membership')

Booking.delete_all()
Member.delete_all()
Session.delete_all()
Room.delete_all()
Membership.delete_all()

standard = Membership.new({
  "type" => "standard",
  "start_time" => "07:00",
  "end_time" => "22:00",
  })
off_peak = Membership.new({
  "type" => "off_peak",
  "start_time" => "18:00",
  "end_time" => "22:00",
  })
standard.save()
off_peak.save()

member1 = Member.new({
  "membership_id" => standard.id,
  "first_name" => "Graham",
  "last_name" => "Grahamson",
  "goal" => "Get stronger"
  })
member2 = Member.new({
  "membership_id" => off_peak.id,
  "first_name" => "Nil",
  "last_name" => "Nilson",
  "goal" => "Get faster"
  })
member1.save()
member2.save()

room1 = Room.new({
  "name" => "Studio",
  "capacity" => 5,
  })
room2 = Room.new({
  "name" => "Weights 1",
  "capacity" => 30,
  })
room1.save()
room2.save()

session1 = Session.new({
  "type" => "Spin",
  "trainer" => "George Smith",
  "room_id" => room1.id,
  "start_time" => "2020-02-14 15:30:00",
  "duration" => 60
  })
session2 = Session.new({
  "type" => "Powerlifting",
  "trainer" => "Nicole Greene",
  "room_id" => room2.id,
  "start_time" => "2020-02-14 19:15:00",
  "duration" => 60
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
