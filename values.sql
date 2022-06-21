-- Drop tables (before presenting project) --
DROP TABLE buildings;
DROP TABLE staff;
DROP TABLE roles;
DROP TABLE cells;
DROP TABLE prisoners;
DROP TABLE weapon_storage;
DROP TABLE crimes;

-- Table creation --

CREATE TABLE buildings
(
    id          NUMBER(10) GENERATED ALWAYS as IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
    name        VARCHAR2(200)                                                         NOT NULL,
    location    VARCHAR2(200)                                                         NOT NULL,
    director_id NUMBER(10)                                                            NOT NULL,
    CONSTRAINT PK_buildings PRIMARY KEY (id)
);

CREATE TABLE staff
(
    id          NUMBER(10) GENERATED ALWAYS as IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
    building_id NUMBER(10)                                                            NOT NULL,
    role_id     NUMBER(10)                                                            NOT NULL,
    name        VARCHAR2(50)                                                          NOT NULL,
    weapon_id   NUMBER(10),
    CONSTRAINT PK_staff PRIMARY KEY (id)
);

CREATE TABLE roles
(
    id   NUMBER(10) GENERATED ALWAYS as IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
    role VARCHAR2(50)                                                          NOT NULL,
    CONSTRAINT PK_roles PRIMARY KEY (id)
);

CREATE TABLE cells
(
    id          NUMBER(10) GENERATED ALWAYS as IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
    cell_name   VARCHAR2(4)                                                           NOT NULL,
    capacity    NUMBER(3)                                                             NOT NULL,
    building_id NUMBER(10)                                                            NOT NULL,
    CONSTRAINT PK_cells PRIMARY KEY (id)
);

CREATE TABLE prisoners
(
    id              NUMBER(10) GENERATED ALWAYS as IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
    name            VARCHAR2(50)                                                          NOT NULL,
    crime_id        NUMBER(10)                                                            NOT NULL,
    cell_id         NUMBER(10)                                                            NOT NULL,
    guard_id        NUMBER(10)                                                            NOT NULL,
    time_of_lock    DATE                                                                  NOT NULL,
    time_of_release DATE                                                                  NOT NULL,
    CONSTRAINT PK_prisoners PRIMARY KEY (id)
);

CREATE TABLE weapon_storage
(
    id              NUMBER(10) GENERATED ALWAYS as IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
    name            VARCHAR2(50)                                                          NOT NULL,
    caliber         VARCHAR2(10),
    lethality_level NUMBER(1)                                                             NOT NULL,
    quantity        NUMBER(10)                                                            NOT NULL,
    CONSTRAINT PK_weapon_storage PRIMARY KEY (id)
);

CREATE TABLE crimes
(
    id          NUMBER(10) GENERATED ALWAYS as IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
    severity    NUMBER(10)                                                            NOT NULL,
    description VARCHAR2(100)                                                         NOT NULL,
    CONSTRAINT PK_crimes PRIMARY KEY (id)
);

CREATE TABLE prisoner_log
(
    id          NUMBER(10) GENERATED ALWAYS as IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
    name        VARCHAR2(50)                                                          NOT NULL,
    time_served NUMBER(10)                                                            NOT NULL
);

CREATE TABLE staff_log
(
    id             NUMBER(10) GENERATED ALWAYS as IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
    name           VARCHAR2(50)                                                          NOT NULL,
    role           VARCHAR2(50)                                                          NOT NULL,
    time_of_firing DATE                                                                  NOT NULL
);

-- Inserting values --
INSERT INTO buildings
VALUES (DEFAULT, 'Állampusztai országos büntetés-végrehajtási intézet - Állampusztai objektum', 'Állampuszta Fő út 1. ',
        1);
INSERT INTO buildings
VALUES (DEFAULT, 'BÁCS-KISKUN MEGYEI BÜNTETÉS-VÉGREHAJTÁSI INTÉZET', 'Kecskemét, Mátyási utca 2.', 13);
INSERT INTO buildings
VALUES (DEFAULT, 'BALASSAGYARMATI FEGYHÁZ ÉS BÖRTÖN', '2660 Balassagyarmat, Madách u. 2.', 25);
INSERT INTO buildings
VALUES (DEFAULT, 'BARANYA MEGYEI BÜNTETÉS-VÉGREHAJTÁSI INTÉZET', '7621 Pécs, Papnövelde u. 7-11.', 37);
INSERT INTO buildings
VALUES (DEFAULT, 'FŐVÁROSI BÜNTETÉS-VÉGREHAJTÁSI INTÉZET', 'I. Objektum: 1055 Budapest, Nagy Ignác u. 5-11.', 49);

INSERT INTO crimes
VALUES (DEFAULT, 1, 'Robbery');
INSERT INTO crimes
VALUES (DEFAULT, 1, 'Gun possession');
INSERT INTO crimes
VALUES (DEFAULT, 1, 'Driving under the influence (DUI)');
INSERT INTO crimes
VALUES (DEFAULT, 2, 'Kidnapping');
INSERT INTO crimes
VALUES (DEFAULT, 2, 'Drug possession');
INSERT INTO crimes
VALUES (DEFAULT, 2, 'Racketeering');
INSERT INTO crimes
VALUES (DEFAULT, 3, 'Rape');
INSERT INTO crimes
VALUES (DEFAULT, 3, 'Murder');
INSERT INTO crimes
VALUES (DEFAULT, 3, 'Vehicular manslaughter');

INSERT INTO weapon_storage
values (DEFAULT, 'Night stick', NULL, 1, 50);
INSERT INTO weapon_storage
values (DEFAULT, 'Taser', NULL, 1, 40);
INSERT INTO weapon_storage
values (DEFAULT, 'Stun gun', NULL, 1, 30);
INSERT INTO weapon_storage
values (DEFAULT, 'Glock 17', '9x19mm', 2, 20);
INSERT INTO weapon_storage
values (DEFAULT, 'Beretta M9', '9x19mm', 2, 20);
INSERT INTO weapon_storage
values (DEFAULT, 'Colt 1911', '.45 ACP', 2, 10);
INSERT INTO weapon_storage
values (DEFAULT, 'Remington Model 870', '12 gauge', 3, 8);
INSERT INTO weapon_storage
values (DEFAULT, 'Heckler & Koch UMP', '.45 ACP', 3, 10);
INSERT INTO weapon_storage
values (DEFAULT, 'ArmaLite AR-15', '.223 Rem', 3, 5);

INSERT INTO roles
values (DEFAULT, 'Director');
INSERT INTO roles
values (DEFAULT, 'Guard');
INSERT INTO roles
values (DEFAULT, 'Cook');
INSERT INTO roles
values (DEFAULT, 'Janitor');
INSERT INTO roles
values (DEFAULT, 'Secretary');

-- First prison values
INSERT INTO staff
values (DEFAULT, 1, 1, 'Molnár István', NULL);
INSERT INTO staff
values (DEFAULT, 1, 2, 'Becze Balázs', NULL);
INSERT INTO staff
values (DEFAULT, 1, 2, 'Ferencz Szilárd', NULL);
INSERT INTO staff
values (DEFAULT, 1, 2, 'Bálint Zsolt', NULL);
INSERT INTO staff
values (DEFAULT, 1, 2, 'Seres Tamás', NULL);
INSERT INTO staff
values (DEFAULT, 1, 2, 'Sakter Előd', NULL);
INSERT INTO staff
values (DEFAULT, 1, 2, 'Laczkó Péter', NULL);
INSERT INTO staff
values (DEFAULT, 1, 2, 'Kovács Benedek', NULL);
INSERT INTO staff
values (DEFAULT, 1, 2, 'Márton András', NULL);
INSERT INTO staff
values (DEFAULT, 1, 3, 'Fodor Melinda', NULL);
INSERT INTO staff
values (DEFAULT, 1, 4, 'Kelemen András', NULL);
INSERT INTO staff
values (DEFAULT, 1, 5, 'Antal Balázs', NULL);
-- Second prison values
INSERT INTO staff
values (DEFAULT, 2, 1, 'Kovács András', NULL);
INSERT INTO staff
values (DEFAULT, 2, 2, 'Gál Attila', NULL);
INSERT INTO staff
values (DEFAULT, 2, 2, 'Katók Ferenc', NULL);
INSERT INTO staff
values (DEFAULT, 2, 2, 'Lukács László', NULL);
INSERT INTO staff
values (DEFAULT, 2, 2, 'Süveg Márk', NULL);
INSERT INTO staff
values (DEFAULT, 2, 2, 'Závada Péter', NULL);
INSERT INTO staff
values (DEFAULT, 2, 2, 'Kanye West', NULL);
INSERT INTO staff
values (DEFAULT, 2, 2, 'Szendrői Csaba', NULL);
INSERT INTO staff
values (DEFAULT, 2, 2, 'Fekete Giorgio', NULL);
INSERT INTO staff
values (DEFAULT, 2, 3, 'Kun Bálint', NULL);
INSERT INTO staff
values (DEFAULT, 2, 4, 'Sólyom Balázs', NULL);
INSERT INTO staff
values (DEFAULT, 2, 5, 'Dénes Dávid', NULL);
-- Third prison values
INSERT INTO staff
values (DEFAULT, 3, 1, 'Péter Árpád', NULL);
INSERT INTO staff
values (DEFAULT, 3, 2, 'Kis-Pál András', NULL);
INSERT INTO staff
values (DEFAULT, 3, 2, 'Bérczes Róbert', NULL);
INSERT INTO staff
values (DEFAULT, 3, 2, 'Mága Zoltán', NULL);
INSERT INTO staff
values (DEFAULT, 3, 2, 'Lakatos Rajmund', NULL);
INSERT INTO staff
values (DEFAULT, 3, 2, 'Damu Roland', NULL);
INSERT INTO staff
values (DEFAULT, 3, 2, 'Mátyus Róbert', NULL);
INSERT INTO staff
values (DEFAULT, 3, 2, 'György Rajmund', NULL);
INSERT INTO staff
values (DEFAULT, 3, 2, 'Vajna Andy', NULL);
INSERT INTO staff
values (DEFAULT, 3, 3, 'Vajna Tímea', NULL);
INSERT INTO staff
values (DEFAULT, 3, 4, 'Bajor Imre', NULL);
INSERT INTO staff
values (DEFAULT, 3, 5, 'Koncz Krisztián', NULL);
-- Fourth prison values
INSERT INTO staff
values (DEFAULT, 4, 1, 'Figura János', NULL);
INSERT INTO staff
values (DEFAULT, 4, 2, 'Akác Mihály', NULL);
INSERT INTO staff
values (DEFAULT, 4, 2, 'Lauretta Paula', NULL);
INSERT INTO staff
values (DEFAULT, 4, 2, 'György András', NULL);
INSERT INTO staff
values (DEFAULT, 4, 2, 'John Lennon', NULL);
INSERT INTO staff
values (DEFAULT, 4, 2, 'Elton John', NULL);
INSERT INTO staff
values (DEFAULT, 4, 2, 'Jamie Foxx', NULL);
INSERT INTO staff
values (DEFAULT, 4, 2, 'Gálvölgyi János', NULL);
INSERT INTO staff
values (DEFAULT, 4, 2, 'Rugós Béla', NULL);
INSERT INTO staff
values (DEFAULT, 4, 3, 'Szalai Ádám', NULL);
INSERT INTO staff
values (DEFAULT, 4, 4, 'Kó Zsolt', NULL);
INSERT INTO staff
values (DEFAULT, 4, 5, 'Márton Béla', NULL);
-- Fifth prison values
INSERT INTO staff
values (DEFAULT, 5, 1, 'Bács Ferenc', NULL);
INSERT INTO staff
values (DEFAULT, 5, 2, 'Mogács Dániel', NULL);
INSERT INTO staff
values (DEFAULT, 5, 2, 'Derzsi Dániel', NULL);
INSERT INTO staff
values (DEFAULT, 5, 2, 'Bagoly Norbert', NULL);
INSERT INTO staff
values (DEFAULT, 5, 2, 'Sallai József', NULL);
INSERT INTO staff
values (DEFAULT, 5, 2, 'Molnár Krisztián', NULL);
INSERT INTO staff
values (DEFAULT, 5, 2, 'Mátyás Anita', NULL);
INSERT INTO staff
values (DEFAULT, 5, 2, 'Incze Zsolt', NULL);
INSERT INTO staff
values (DEFAULT, 5, 2, 'Finta Tamás', NULL);
INSERT INTO staff
values (DEFAULT, 5, 3, 'László Hunor', NULL);
INSERT INTO staff
values (DEFAULT, 5, 4, 'Kelemen Irénke', NULL);
INSERT INTO staff
values (DEFAULT, 5, 5, 'Kilyén Dávid', NULL);


INSERT INTO cells
values (DEFAULT, 'A1', 5, 1);
INSERT INTO cells
values (DEFAULT, 'A2', 5, 1);
INSERT INTO cells
values (DEFAULT, 'A3', 5, 1);
INSERT INTO cells
values (DEFAULT, 'B1', 5, 1);
INSERT INTO cells
values (DEFAULT, 'B2', 5, 1);
INSERT INTO cells
values (DEFAULT, 'B3', 5, 1);
INSERT INTO cells
values (DEFAULT, 'C1', 5, 1);
INSERT INTO cells
values (DEFAULT, 'C2', 5, 1);
INSERT INTO cells
values (DEFAULT, 'C3', 5, 1);

INSERT INTO cells
values (DEFAULT, 'A1', 5, 2);
INSERT INTO cells
values (DEFAULT, 'A2', 5, 2);
INSERT INTO cells
values (DEFAULT, 'A3', 5, 2);
INSERT INTO cells
values (DEFAULT, 'B1', 5, 2);
INSERT INTO cells
values (DEFAULT, 'B2', 5, 2);
INSERT INTO cells
values (DEFAULT, 'B3', 5, 2);
INSERT INTO cells
values (DEFAULT, 'C1', 5, 2);
INSERT INTO cells
values (DEFAULT, 'C2', 5, 2);
INSERT INTO cells
values (DEFAULT, 'C3', 5, 2);

INSERT INTO cells
values (DEFAULT, 'A1', 5, 3);
INSERT INTO cells
values (DEFAULT, 'A2', 5, 3);
INSERT INTO cells
values (DEFAULT, 'A3', 5, 3);
INSERT INTO cells
values (DEFAULT, 'B1', 5, 3);
INSERT INTO cells
values (DEFAULT, 'B2', 5, 3);
INSERT INTO cells
values (DEFAULT, 'B3', 5, 3);
INSERT INTO cells
values (DEFAULT, 'C1', 5, 3);
INSERT INTO cells
values (DEFAULT, 'C2', 5, 3);
INSERT INTO cells
values (DEFAULT, 'C3', 5, 3);


INSERT INTO cells
values (DEFAULT, 'A1', 5, 4);
INSERT INTO cells
values (DEFAULT, 'A2', 5, 4);
INSERT INTO cells
values (DEFAULT, 'A3', 5, 4);
INSERT INTO cells
values (DEFAULT, 'B1', 5, 4);
INSERT INTO cells
values (DEFAULT, 'B2', 5, 4);
INSERT INTO cells
values (DEFAULT, 'B3', 5, 4);
INSERT INTO cells
values (DEFAULT, 'C1', 5, 4);
INSERT INTO cells
values (DEFAULT, 'C2', 5, 4);
INSERT INTO cells
values (DEFAULT, 'C3', 5, 4);

INSERT INTO cells
values (DEFAULT, 'A1', 5, 5);
INSERT INTO cells
values (DEFAULT, 'A2', 5, 5);
INSERT INTO cells
values (DEFAULT, 'A3', 5, 5);
INSERT INTO cells
values (DEFAULT, 'B1', 5, 5);
INSERT INTO cells
values (DEFAULT, 'B2', 5, 5);
INSERT INTO cells
values (DEFAULT, 'B3', 5, 5);
INSERT INTO cells
values (DEFAULT, 'C1', 5, 5);
INSERT INTO cells
values (DEFAULT, 'C2', 5, 5);
INSERT INTO cells
values (DEFAULT, 'C3', 5, 5);


-- Foreign keys --
ALTER TABLE buildings
    ADD CONSTRAINT FK_director_id FOREIGN KEY (director_id) REFERENCES staff (id);

ALTER TABLE staff
    ADD CONSTRAINT FK_building_id FOREIGN KEY (building_id) REFERENCES buildings (id);

ALTER TABLE staff
    ADD CONSTRAINT FK_role_id FOREIGN KEY (role_id) REFERENCES roles (id);

ALTER TABLE staff
    ADD CONSTRAINT FK_weapon_id FOREIGN KEY (weapon_id) REFERENCES weapon_storage (id);

ALTER TABLE cells
    ADD CONSTRAINT FK_cells_building_id FOREIGN KEY (building_id) REFERENCES buildings (id);

ALTER TABLE prisoners
    ADD CONSTRAINT FK_crime_id FOREIGN KEY (crime_id) REFERENCES crimes (id);

ALTER TABLE prisoners
    ADD CONSTRAINT FK_cell_id FOREIGN KEY (cell_id) REFERENCES cells (id);

ALTER TABLE prisoners
    ADD CONSTRAINT FK_guard_id FOREIGN KEY (guard_id) REFERENCES staff (id);