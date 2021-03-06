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
VALUES (DEFAULT, '??llampusztai orsz??gos b??ntet??s-v??grehajt??si int??zet - ??llampusztai objektum', '??llampuszta F?? ??t 1. ',
        1);
INSERT INTO buildings
VALUES (DEFAULT, 'B??CS-KISKUN MEGYEI B??NTET??S-V??GREHAJT??SI INT??ZET', 'Kecskem??t, M??ty??si utca 2.', 13);
INSERT INTO buildings
VALUES (DEFAULT, 'BALASSAGYARMATI FEGYH??Z ??S B??RT??N', '2660 Balassagyarmat, Mad??ch u. 2.', 25);
INSERT INTO buildings
VALUES (DEFAULT, 'BARANYA MEGYEI B??NTET??S-V??GREHAJT??SI INT??ZET', '7621 P??cs, Papn??velde u. 7-11.', 37);
INSERT INTO buildings
VALUES (DEFAULT, 'F??V??ROSI B??NTET??S-V??GREHAJT??SI INT??ZET', 'I. Objektum: 1055 Budapest, Nagy Ign??c u. 5-11.', 49);

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
values (DEFAULT, 1, 1, 'Moln??r Istv??n', NULL);
INSERT INTO staff
values (DEFAULT, 1, 2, 'Becze Bal??zs', NULL);
INSERT INTO staff
values (DEFAULT, 1, 2, 'Ferencz Szil??rd', NULL);
INSERT INTO staff
values (DEFAULT, 1, 2, 'B??lint Zsolt', NULL);
INSERT INTO staff
values (DEFAULT, 1, 2, 'Seres Tam??s', NULL);
INSERT INTO staff
values (DEFAULT, 1, 2, 'Sakter El??d', NULL);
INSERT INTO staff
values (DEFAULT, 1, 2, 'Laczk?? P??ter', NULL);
INSERT INTO staff
values (DEFAULT, 1, 2, 'Kov??cs Benedek', NULL);
INSERT INTO staff
values (DEFAULT, 1, 2, 'M??rton Andr??s', NULL);
INSERT INTO staff
values (DEFAULT, 1, 3, 'Fodor Melinda', NULL);
INSERT INTO staff
values (DEFAULT, 1, 4, 'Kelemen Andr??s', NULL);
INSERT INTO staff
values (DEFAULT, 1, 5, 'Antal Bal??zs', NULL);
-- Second prison values
INSERT INTO staff
values (DEFAULT, 2, 1, 'Kov??cs Andr??s', NULL);
INSERT INTO staff
values (DEFAULT, 2, 2, 'G??l Attila', NULL);
INSERT INTO staff
values (DEFAULT, 2, 2, 'Kat??k Ferenc', NULL);
INSERT INTO staff
values (DEFAULT, 2, 2, 'Luk??cs L??szl??', NULL);
INSERT INTO staff
values (DEFAULT, 2, 2, 'S??veg M??rk', NULL);
INSERT INTO staff
values (DEFAULT, 2, 2, 'Z??vada P??ter', NULL);
INSERT INTO staff
values (DEFAULT, 2, 2, 'Kanye West', NULL);
INSERT INTO staff
values (DEFAULT, 2, 2, 'Szendr??i Csaba', NULL);
INSERT INTO staff
values (DEFAULT, 2, 2, 'Fekete Giorgio', NULL);
INSERT INTO staff
values (DEFAULT, 2, 3, 'Kun B??lint', NULL);
INSERT INTO staff
values (DEFAULT, 2, 4, 'S??lyom Bal??zs', NULL);
INSERT INTO staff
values (DEFAULT, 2, 5, 'D??nes D??vid', NULL);
-- Third prison values
INSERT INTO staff
values (DEFAULT, 3, 1, 'P??ter ??rp??d', NULL);
INSERT INTO staff
values (DEFAULT, 3, 2, 'Kis-P??l Andr??s', NULL);
INSERT INTO staff
values (DEFAULT, 3, 2, 'B??rczes R??bert', NULL);
INSERT INTO staff
values (DEFAULT, 3, 2, 'M??ga Zolt??n', NULL);
INSERT INTO staff
values (DEFAULT, 3, 2, 'Lakatos Rajmund', NULL);
INSERT INTO staff
values (DEFAULT, 3, 2, 'Damu Roland', NULL);
INSERT INTO staff
values (DEFAULT, 3, 2, 'M??tyus R??bert', NULL);
INSERT INTO staff
values (DEFAULT, 3, 2, 'Gy??rgy Rajmund', NULL);
INSERT INTO staff
values (DEFAULT, 3, 2, 'Vajna Andy', NULL);
INSERT INTO staff
values (DEFAULT, 3, 3, 'Vajna T??mea', NULL);
INSERT INTO staff
values (DEFAULT, 3, 4, 'Bajor Imre', NULL);
INSERT INTO staff
values (DEFAULT, 3, 5, 'Koncz Kriszti??n', NULL);
-- Fourth prison values
INSERT INTO staff
values (DEFAULT, 4, 1, 'Figura J??nos', NULL);
INSERT INTO staff
values (DEFAULT, 4, 2, 'Ak??c Mih??ly', NULL);
INSERT INTO staff
values (DEFAULT, 4, 2, 'Lauretta Paula', NULL);
INSERT INTO staff
values (DEFAULT, 4, 2, 'Gy??rgy Andr??s', NULL);
INSERT INTO staff
values (DEFAULT, 4, 2, 'John Lennon', NULL);
INSERT INTO staff
values (DEFAULT, 4, 2, 'Elton John', NULL);
INSERT INTO staff
values (DEFAULT, 4, 2, 'Jamie Foxx', NULL);
INSERT INTO staff
values (DEFAULT, 4, 2, 'G??lv??lgyi J??nos', NULL);
INSERT INTO staff
values (DEFAULT, 4, 2, 'Rug??s B??la', NULL);
INSERT INTO staff
values (DEFAULT, 4, 3, 'Szalai ??d??m', NULL);
INSERT INTO staff
values (DEFAULT, 4, 4, 'K?? Zsolt', NULL);
INSERT INTO staff
values (DEFAULT, 4, 5, 'M??rton B??la', NULL);
-- Fifth prison values
INSERT INTO staff
values (DEFAULT, 5, 1, 'B??cs Ferenc', NULL);
INSERT INTO staff
values (DEFAULT, 5, 2, 'Mog??cs D??niel', NULL);
INSERT INTO staff
values (DEFAULT, 5, 2, 'Derzsi D??niel', NULL);
INSERT INTO staff
values (DEFAULT, 5, 2, 'Bagoly Norbert', NULL);
INSERT INTO staff
values (DEFAULT, 5, 2, 'Sallai J??zsef', NULL);
INSERT INTO staff
values (DEFAULT, 5, 2, 'Moln??r Kriszti??n', NULL);
INSERT INTO staff
values (DEFAULT, 5, 2, 'M??ty??s Anita', NULL);
INSERT INTO staff
values (DEFAULT, 5, 2, 'Incze Zsolt', NULL);
INSERT INTO staff
values (DEFAULT, 5, 2, 'Finta Tam??s', NULL);
INSERT INTO staff
values (DEFAULT, 5, 3, 'L??szl?? Hunor', NULL);
INSERT INTO staff
values (DEFAULT, 5, 4, 'Kelemen Ir??nke', NULL);
INSERT INTO staff
values (DEFAULT, 5, 5, 'Kily??n D??vid', NULL);


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