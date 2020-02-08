require('pry')
require_relative('../models/member')
require_relative('../models/session')

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

binding.pry
nil
