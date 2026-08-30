-- db/schema.sql

-- users
CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE users (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  phone varchar(20) UNIQUE,
  name varchar(64),
  avatar text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE doctors (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name varchar(64),
  hospital varchar(128),
  specialties jsonb,
  credential_docs jsonb,
  rating numeric DEFAULT 0,
  price numeric DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE pets (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  owner_id uuid REFERENCES users(id),
  name varchar(64),
  species varchar(64),
  breed varchar(128),
  sex varchar(8),
  birth_date date,
  weight numeric,
  length numeric,
  tags jsonb,
  photos jsonb,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE consults (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES users(id),
  doctor_id uuid REFERENCES doctors(id),
  pet_id uuid REFERENCES pets(id),
  description text,
  media jsonb,
  status varchar(32) DEFAULT 'pending',
  price numeric DEFAULT 0,
  payment_info jsonb,
  created_at timestamptz DEFAULT now()
);
