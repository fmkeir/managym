DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS sessions;
DROP TABLE IF EXISTS rooms;

CREATE TABLE rooms (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  capacity INT
);

CREATE TABLE members (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  goal VARCHAR(255)
);

CREATE TABLE sessions (
  id SERIAL PRIMARY KEY,
  type VARCHAR(255),
  trainer VARCHAR(255),
  room_id INT REFERENCES rooms(id) ON DELETE CASCADE
);

CREATE TABLE bookings (
  id SERIAL PRIMARY KEY,
  member_id INT REFERENCES members(id) ON DELETE CASCADE,
  session_id INT REFERENCES sessions(id) ON DELETE CASCADE
);
