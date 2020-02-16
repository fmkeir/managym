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
  "membership_id" => standard.id,
  "first_name" => "Nil",
  "last_name" => "Nilson",
  "goal" => "Get faster"
  })
member3 = Member.new({
  "membership_id" => standard.id,
  "first_name" => "Sara",
  "last_name" => "Sigmundsdottir",
  "goal" => "Get faster"
  })
member4 = Member.new({
  "membership_id" => standard.id,
  "first_name" => "Kara",
  "last_name" => "Webb",
  "goal" => "Rebuild fitness"
  })
member5 = Member.new({
  "membership_id" => standard.id,
  "first_name" => "Mat",
  "last_name" => "Fraser",
  "goal" => "Eliminate weaknesses"
  })
member6 = Member.new({
  "membership_id" => standard.id,
  "first_name" => "Frederik",
  "last_name" => "Aegidius",
  "goal" => "Maintain fitness"
  })
member7 = Member.new({
  "membership_id" => off_peak.id,
  "first_name" => "Jamie",
  "last_name" => "Greene",
  "goal" => "Have fun"
  })
member8 = Member.new({
  "membership_id" => off_peak.id,
  "first_name" => "John",
  "last_name" => "Jacob",
  "goal" => "Get hench"
  })
member1.save()
member2.save()
member3.save()
member4.save()
member5.save()
member6.save()
member7.save()
member8.save()

room1 = Room.new({
  "name" => "Studio",
  "capacity" => 5,
  })
room2 = Room.new({
  "name" => "Weights",
  "capacity" => 20,
  })
room3 = Room.new({
  "name" => "Main hall",
  "capacity" => 40,
  })
room4 = Room.new({
  "name" => "PT area",
  "capacity" => 2,
  })
room1.save()
room2.save()
room3.save()
room4.save()

session1 = Session.new({
  "type" => "Spin",
  "trainer" => "George Smith",
  "room_id" => room1.id,
  "start_time" => "2020-02-14 15:30:00",
  "duration" => 30
  })
session2 = Session.new({
  "type" => "Powerlifting",
  "trainer" => "Nicole Greene",
  "room_id" => room2.id,
  "start_time" => "2020-02-14 19:15:00",
  "duration" => 60
  })
session3 = Session.new({
  "type" => "Gymnastics",
  "trainer" => "Ben Jones",
  "room_id" => room1.id,
  "start_time" => "2020-02-11 12:00:00",
  "duration" => 60
  })
session4 = Session.new({
  "type" => "Strongman",
  "trainer" => "Anna Telford",
  "room_id" => room3.id,
  "start_time" => "2020-02-28 20:00:00",
  "duration" => 60
  })
session3.save()
session4.save()
Session.recurring_save(session1, 7)
Session.recurring_save(session2, 7)

booking1 = Booking.new({
  "member_id" => member1.id,
  "session_id" => session1.id
  })
booking2 = Booking.new({
  "member_id" => member2.id,
  "session_id" => session1.id
  })
booking3 = Booking.new({
  "member_id" => member3.id,
  "session_id" => session1.id
  })
booking4 = Booking.new({
  "member_id" => member4.id,
  "session_id" => session1.id
  })
booking5 = Booking.new({
  "member_id" => member5.id,
  "session_id" => session2.id
  })
booking6 = Booking.new({
  "member_id" => member6.id,
  "session_id" => session2.id
  })
booking7 = Booking.new({
  "member_id" => member7.id,
  "session_id" => session2.id
  })
booking8 = Booking.new({
  "member_id" => member8.id,
  "session_id" => session2.id
  })
booking1.save()
booking2.save()
booking3.save()
booking4.save()
booking5.save()
booking6.save()
booking7.save()
booking8.save()

binding.pry
nil
