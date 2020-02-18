require_relative('../models/member')
require_relative('../models/session')
require_relative('../models/booking')
require_relative('../models/room')
require_relative('../models/membership')
require_relative('../helpers/seeding')
srand(8)

Booking.delete_all()
Member.delete_all()
Session.delete_all()
Room.delete_all()
Membership.delete_all()

# Populate database with fixed random data

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

members = [
  member1, member2, member3, member4,
  member5, member6, member7, member8
  ]
members.each {|member| member.save()}

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
  "name" => "PT Area",
  "capacity" => 2,
  })
room1.save()
room2.save()
room3.save()
room4.save()

session1 = Session.new({
  "type" => "Circuits",
  "trainer" => "George Smith",
  "room_id" => room1.id,
  "start_time" => "2020-02-11 15:30:00",
  "duration" => 30
  })
session2 = Session.new({
  "type" => "Powerlifting",
  "trainer" => "Nicole Greene",
  "room_id" => room2.id,
  "start_time" => "2020-02-11 19:15:00",
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
  "start_time" => "2020-02-11 20:00:00",
  "duration" => 60
  })

sessions = [session1, session2, session3, session4]
Session.recurring_save(session1, 3)
Session.recurring_save(session2, 3)
Session.recurring_save(session3, 3)
Session.recurring_save(session4, 3)

random_booking(members, sessions, 20)

# Add a class near booking capacity to demonstrate capacity, membership, and member in class errors
error_session = Session.new({
  "type" => "Private group",
  "trainer" => "Eleanor Shellstrop",
  "room_id" => room4.id,
  "start_time" => "2020-02-28 14:00:00",
  "duration" => 30
  })
error_session.save()

booking1 = Booking.new({
  "member_id" => member1.id,
  "session_id" => error_session.id,
  })
booking2 = Booking.new({
  "member_id" => member3.id,
  "session_id" => error_session.id,
  })
booking1.save()
booking2.save()

# Create a member with no bookings to demonstrate alternate display
member9 = Member.new({
  "membership_id" => off_peak.id,
  "first_name" => "Bill",
  "last_name" => "Billson",
  "goal" => "Start fitness"
  })
