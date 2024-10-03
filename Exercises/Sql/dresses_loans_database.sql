-- Migrations will appear here as you chat with AI

create table clients (
  id bigint primary key generated always as identity,
  name text not null,
  email text unique not null,
  phone text,
  address text
);

create table products (
  id bigint primary key generated always as identity,
  name text not null,
  description text,
  category text,
  quantity int not null
);

create table loans (
  id bigint primary key generated always as identity,
  client_id bigint references clients (id),
  product_id bigint references products (id),
  loan_date date not null,
  return_date date,
  status text not null
);

create table notifications (
  id bigint primary key generated always as identity,
  client_id bigint references clients (id),
  message text not null,
  sent_at timestamp with time zone default now()
);

create table users (
  id bigint primary key generated always as identity,
  username text unique not null,
  password_hash text not null,
  email text unique not null,
  role text not null
);

create table user_sessions (
  id bigint primary key generated always as identity,
  user_id bigint references users (id),
  session_token text unique not null,
  created_at timestamp with time zone default now(),
  expires_at timestamp with time zone
);

create table product_photos (
  id bigint primary key generated always as identity,
  product_id bigint references products (id),
  photo_url text not null,
  description text
);

alter table loans
add column start_date date not null,
add column finish_date date not null;

create table loan_statuses (
  id bigint primary key generated always as identity,
  loan_id bigint references loans (id),
  status text not null,
  updated_at timestamp with time zone default now(),
  comment text
);