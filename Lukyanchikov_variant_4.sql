
-- Лукьянчиков Валерий Геннадьевич
-- Вариант 4
-- Задание: описание хранящихся на складе товаров.
-- Необходимо создать таблицы помещений, стеллажей, клиентов и товаров.
-- На одном стеллаже могут храниться товары разных клиентов.

CREATE TABLE rooms (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    useful_volume NUMERIC(10, 2) NOT NULL CHECK (useful_volume > 0),
    min_temperature NUMERIC(5, 2) NOT NULL,
    max_temperature NUMERIC(5, 2) NOT NULL,
    min_humidity NUMERIC(5, 2) NOT NULL,
    max_humidity NUMERIC(5, 2) NOT NULL,
    CHECK (min_temperature <= max_temperature),
    CHECK (min_humidity BETWEEN 0 AND 100),
    CHECK (max_humidity BETWEEN 0 AND 100),
    CHECK (min_humidity <= max_humidity)
);

CREATE TABLE racks (
    id SERIAL PRIMARY KEY,
    rack_number INTEGER NOT NULL,
    room_id INTEGER NOT NULL REFERENCES rooms(id),
    places_count INTEGER NOT NULL CHECK (places_count > 0),
    place_height NUMERIC(10, 2) NOT NULL CHECK (place_height > 0),
    place_width NUMERIC(10, 2) NOT NULL CHECK (place_width > 0),
    place_length NUMERIC(10, 2) NOT NULL CHECK (place_length > 0),
    max_load NUMERIC(10, 2) NOT NULL CHECK (max_load > 0),
    UNIQUE (room_id, rack_number)
);

CREATE TABLE clients (
    id SERIAL PRIMARY KEY,
    company_name VARCHAR(200) NOT NULL,
    bank_details TEXT NOT NULL
);

CREATE TABLE goods (
    id SERIAL PRIMARY KEY,
    height NUMERIC(10, 2) NOT NULL CHECK (height > 0),
    width NUMERIC(10, 2) NOT NULL CHECK (width > 0),
    length NUMERIC(10, 2) NOT NULL CHECK (length > 0),
    weight NUMERIC(10, 2) NOT NULL CHECK (weight > 0),
    arrival_date DATE NOT NULL DEFAULT CURRENT_DATE,
    contract_number VARCHAR(50) NOT NULL,
    client_id INTEGER NOT NULL REFERENCES clients(id),
    contract_end_date DATE NOT NULL,
    min_temperature NUMERIC(5, 2) NOT NULL,
    max_temperature NUMERIC(5, 2) NOT NULL,
    min_humidity NUMERIC(5, 2) NOT NULL,
    max_humidity NUMERIC(5, 2) NOT NULL,
    rack_id INTEGER NOT NULL REFERENCES racks(id),
    position_number INTEGER NOT NULL CHECK (position_number > 0),
    CHECK (contract_end_date >= arrival_date),
    CHECK (min_temperature <= max_temperature),
    CHECK (min_humidity BETWEEN 0 AND 100),
    CHECK (max_humidity BETWEEN 0 AND 100),
    CHECK (min_humidity <= max_humidity),
    UNIQUE (rack_id, position_number)
);
