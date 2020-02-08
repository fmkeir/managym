DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS sessions;

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
  Capacity INT
);

CREATE TABLE bookings (
  id SERIAL PRIMARY KEY,
  member_id INT REFERENCES members(id),
  session_id INT REFERENCES sessions(id)
);
