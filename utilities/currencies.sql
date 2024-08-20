create table currencies (
  id bigint primary key generated always as identity,
  name text not null,
  code text not null unique,
  symbol text,
  seed numeric(10, 2) not null
);

alter table currencies
add column exchange_rate_to_usd numeric(10, 4) not null;

create table currency_variations (
  id bigint primary key generated always as identity,
  currency_id bigint not null references currencies (id),
  date date not null,
  value_change numeric(10, 4),
  percentage_change numeric(5, 2),
  constraint unique_currency_date unique (currency_id, date)
);

alter table currency_variations
alter column date type timestamp with time zone;

create table transactions (
  id bigint primary key generated always as identity,
  from_account_id bigint not null,
  to_account_id bigint not null,
  transaction_date timestamp with time zone not null,
  amount numeric(10, 2) not null,
  from_currency_id bigint not null references currencies (id),
  to_currency_id bigint not null references currencies (id),
  exchange_rate_id bigint references currency_variations (id),
  exchange_rate_value numeric(10, 4)
);