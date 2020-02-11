DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS sessions;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS memberships;

CREATE TABLE rooms (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  capacity INT
);

CREATE TABLE memberships (
  id SERIAL PRIMARY KEY,
  type VARCHAR(255),
  start_time TIME,
  end_time TIME
);

CREATE TABLE members (
  id SERIAL PRIMARY KEY,
  membership_id INT REFERENCES memberships(id) ON DELETE CASCADE,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  goal VARCHAR(255)
);

CREATE TABLE sessions (
  id SERIAL PRIMARY KEY,
  type VARCHAR(255),
  trainer VARCHAR(255),
  room_id INT REFERENCES rooms(id) ON DELETE CASCADE,
  start_time TIMESTAMP,
  duration INT
);

CREATE TABLE bookings (
  id SERIAL PRIMARY KEY,
  member_id INT REFERENCES members(id) ON DELETE CASCADE,
  session_id INT REFERENCES sessions(id) ON DELETE CASCADE
);
