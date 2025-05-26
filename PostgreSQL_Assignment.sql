-- Active: 1747470044578@@127.0.0.1@5432@conservation_db

-- Create Tables
CREATE TABLE rangers(
    ranger_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    region TEXT NOT NULL
);

CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name TEXT NOT NULL,
    scientific_name TEXT NOT NULL UNIQUE,
    discovery_date DATE NOT NULL,
    conservation_status TEXT NOT NULL
);

CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INT NOT NULL REFERENCES rangers(ranger_id) ON DELETE CASCADE,
    species_id INT NOT NULL REFERENCES species(species_id) ON DELETE CASCADE,
    sighting_time TIMESTAMP NOT NULL,
    location TEXT NOT NULL,
    notes TEXT
);

-- Insert Data Into Tables
INSERT INTO rangers (name, region) VALUES
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range');

INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);


-- Problem 1
INSERT INTO rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');

-- Problem 2
SELECT COUNT(DISTINCT species_id) AS unique_species_count FROM sightings;

-- Problem 3
SELECT * FROM sightings
WHERE location ILIKE '%Pass%';

-- Problem 4
SELECT name, COUNT(*) AS total_sightings
FROM rangers
JOIN sightings USING (ranger_id)
GROUP BY name
ORDER BY name;

-- Problem 5
SELECT common_name
FROM species
WHERE species_id NOT IN (
    SELECT DISTINCT species_id
    FROM sightings
);

-- Problem 6
SELECT species.common_name, sightings.sighting_time, rangers.name FROM sightings
INNER JOIN species ON sightings.species_id = species.species_id
INNER JOIN rangers ON sightings.ranger_id = rangers.ranger_id
ORDER BY sightings.sighting_time DESC
LIMIT 2;

-- Problem 7
UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < DATE '1800-01-01';

-- SELECT common_name, discovery_date, conservation_status FROM species
-- WHERE discovery_date < '1800-01-01';

-- Problem 8

-- Problem 9
DELETE FROM rangers
WHERE ranger_id NOT IN (
    SELECT DISTINCT ranger_id
    FROM sightings
);

-- Check who are going to be delete
SELECT * FROM rangers
WHERE ranger_id NOT IN (
    SELECT DISTINCT ranger_id FROM sightings
);
