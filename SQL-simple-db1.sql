CREATE DATABASE playground;

USE playground;

CREATE TABLE users (
	user_id INT NOT NULL AUTO_INCREMENT,
    login varchar(20) NOT NULL,
    display_name varchar(20),
    date_of_birth varchar(10),
    primary key (user_id)
);

CREATE TABLE users_group (
	group_id int NOT NULL AUTO_INCREMENT,
    group_name varchar(20) NOT NULL,
    PRIMARY KEY (group_id)
);

CREATE TABLE users_to_group (
	id INT NOT NULL AUTO_INCREMENT,
    user_id INT,
    group_id INT,
    PRIMARY KEY (id)
);

INSERT INTO users (user_id, login, display_name, date_of_birth)
VALUES (DEFAULT, 'raven', 'Ravcio', '29-04-1990'),
	   (DEFAULT, 'benio', 'Benisław','23-02-1993'),
       (DEFAULT, 'sitak', 'Siny','30-08-1998'),
       (DEFAULT, 'alex', 'OLO98','23-02-1998'),
       (DEFAULT, 'Henio', 'Himi-to','23-12-1995'),
       (DEFAULT, 'Fazi', 'Faryzeusz','11-11-1989')
;

INSERT INTO users_group (group_id, group_name)
VALUES (DEFAULT, 'Programiści'),
	   (DEFAULT, 'Kierowcy'),
       (DEFAULT, 'Malarze'),
       (DEFAULT, 'Hydraulicy'),
       (DEFAULT, 'Bokserzy'),
       (DEFAULT, 'Hutnicy'),
	   (DEFAULT, 'Nauczyciele')
;

INSERT INTO users_to_group (id, user_id, group_id)
VALUES (DEFAULT, 1, 2),
	   (DEFAULT, 1, 3),
       (DEFAULT, 2, 1),
       (DEFAULT, 3, 2),
       (DEFAULT, 3, 6),
       (DEFAULT, 4, 4),
       (DEFAULT, 5, 5),
       (DEFAULT, 6, 3),
       (DEFAULT, 6, 4),
       (DEFAULT, 6, 5),
       (DEFAULT, 6, 4),
       (DEFAULT, 1, 4),
       (DEFAULT, 6, 2)
;
 
SELECT * FROM users;
SELECT * FROM users_group;
SELECT * FROM users_to_group;

-- show users in group nr 6
SELECT * 
FROM users 
WHERE user_id IN (SELECT user_id FROM users_to_group WHERE group_id = 6);

-- print group with have more than 1 users 
-- sort by amount of user
SELECT ug.group_name, count(u.login) as 'amount_of_users'
FROM users as u
JOIN users_to_group as utg on (u.user_id = utg.user_id)
JOIN users_group as ug on (ug.group_id = utg.group_id)
GROUP BY ug.group_name
HAVING amount_of_users > 1
ORDER BY amount_of_users DESC
;

-- print how many group was assigned to each user
-- sort by amout of group
SELECT 
	u.login,
	count(ug.group_name) as 'amount_of_group'
FROM users as u
JOIN users_to_group as utg on (u.user_id = utg.user_id)
JOIN users_group as ug on (utg.group_id = ug.group_id)
GROUP BY u.login
ORDER BY amount_of_group DESC
;

-- average amout assinged group for each user
SELECT FORMAT(AVG(amount_of_group),2) as 'average_assigned_group' 
FROM ( 
		SELECT user_id,
		count(group_id) AS 'amount_of_group'
	    FROM users_to_group
		GROUP BY user_id
	 ) average
;

-- show all users with group
SELECT 
	u.user_id,
	u.display_name,
    ug.group_name
FROM users AS u
JOIN users_to_group AS utg ON u.user_id = utg.user_id
JOIN users_group AS ug ON utg.group_id = ug.group_id
;

-- show all plumbers
SELECT 
	DISTINCT u.display_name AS 'plumbers'
 -- ug.group_name
FROM users AS u
JOIN users_to_group AS utg ON u.user_id = utg.user_id
JOIN users_group AS ug ON utg.group_id = ug.group_id
WHERE group_name in ('Hydraulicy')
;

-- left join
-- 
