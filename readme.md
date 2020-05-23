## Codeclan: Project 1 - Managym

[This project is hosted on Heroku](https://managym.herokuapp.com)

This app is the result of my week 4 individual project, for CodeClan's professional software development course. Ruby, Sinatra, and PostgreSQL were used to build a CRUD app with Restful routes.

The project is designed to help a gym manager keep track of members, classes, and bookings. The demo below shows the process of adding a new member, signing them up for a class, and deleting their booking.

![Demo](./public/images/readme/demo.gif "Website demo")
-

The app has built-in error handling to check whether or not a member can be booked into a class. The private group session with Eleanor Shellstrop can be used to test the error messages. It's a full session in a restricted time slot. The membership type is checked before the session capacity, so that the manager knows not to try and book the member into another session in that time slot.

- Use John Jacob or Jamie Greene to see the invalid membership error
- Use any other member to see the session full error
- Use Graham Grahamson or Sara Sigmundsdottir to see the member already in session error

![Homepage](./public/images/readme/error_class_full.png "Class full")
-
The app can also be used on mobile.
<img src="./public/images/readme/mobile.png" width="200" alt="Mobile view" />

### Getting started

#### Project setup
Install required modules, create and seed database.

```
bundle install
createdb gym
ruby db/seeds.rb
```

#### Using the project

Host the app locally using Sinatra, defaults to port 4567

```
ruby main.rb
```

### Code discussion

#### SQL vs. Ruby for comparisons
This function checks if there is enough space in a session for another member to join.

**Original method:** inefficiently creates member objects just to count them.

```ruby
def enough_space?()
  return members().count() < capacity()
end
```
**Second method:** performs the whole comparison in SQL. Much more efficient but significantly less readable/reusable.

```ruby
def enough_space?()
  sql = "SELECT
  (SELECT count(members.*) FROM members
  INNER JOIN bookings
  ON bookings.member_id = members.id
  WHERE bookings.session_id = $1)
  <
  (SELECT capacity FROM rooms WHERE id = $2)
  as result"
  values = [@id, @room_id]
  return SqlRunner.run(sql, values)[0]["result"] == "t"
end
```
**Production method:** compromises to perform the row counting in SQL, and use Ruby for the capacity comparison. The method members_count() was subsequently used elsewhere in the code.

```ruby
def enough_space?()
  return members_count() < capacity()
end
```
#### Recurring save for sessions
This method uses a loop to create multiple sessions spaced 24 hours apart. This could be used to quickly generate a weekly timetable.


```ruby
def self.recurring_save(session, days_to_repeat)
  days_to_repeat.to_i.times do
    session.save()
    new_date = DateTime.parse(session.start_time) + 1
    session.start_time = new_date.to_s
  end
end
```
#### Filtering session times
This method filters the displayed sessions in SQL before they are sent to the view.

```ruby
def self.filter_date_range(start_date, end_date)
  sql = "SELECT * FROM sessions WHERE start_time >= $1 AND start_time <= $2"
  values = [start_date, end_date]
  return SqlRunner.run(sql, values).map {|session| Session.new(session)}
end
```

#### Seed database with controlled random data
This method, along with srand, allows for a consistent and large dataset to be generated for testing. Each member is looped through and a series of random bookings made. This helps to minimise wasted attempts from members trying to book sessions they are already in.

The method attempts a random number of bookings for each member, ensuring that each member has at least some bookings. The method prevents an infinite loop by skipping to the next member when the current member has as many attempts as sessions that exist.

```ruby
def random_booking(members, sessions, max_member_bookings)
  number_of_sessions = sessions.count()
  for member in members
    member_bookings = rand((number_of_sessions/3)..max_member_bookings)
    bookings_made = 0
    attempts = 0
    until bookings_made == member_bookings || attempts >= number_of_sessions
      if Booking.create(member, sessions.sample()) == "Done"
        bookings_made += 1
      end
      attempts += 1
    end
  end
end
```

### Features
* Create, read, update, and delete: members, membership types, sessions, bookings, and rooms
* Booking creation is limited by session capacity and membership type
* Appropriate errors are handled when a booking cannot be made
* Multiple daily repeat sessions can be made easily in the create session view
* Sessions can be filtered by date
