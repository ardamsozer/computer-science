DROP VIEW IF EXISTS q0, q1i, q1ii, q1iii, q1iv, q2i, q2ii, q2iii, q3i, q3ii, q3iii, q4i, q4ii, q4iii, q4iv, q4v;

-- Question 0
CREATE VIEW q0(era) 
AS
 SELECT MAX(era)
 FROM pitching
;

-- Question 1i
CREATE VIEW q1i(namefirst, namelast, birthyear)
AS
  SELECT namefirst, namelast, birthyear
  FROM people
  WHERE weight > 300
;

-- Question 1ii
CREATE VIEW q1ii(namefirst, namelast, birthyear)
AS
  SELECT namefirst, namelast, birthyear
  FROM people
  WHERE namefirst LIKE '% %'
;

-- Question 1iii
CREATE VIEW q1iii(birthyear, avgheight, count)
AS
  SELECT birthyear, avg(height), count(*)
  FROM people
  GROUP BY birthyear
  ORDER BY birthyear
;

-- Question 1iv
CREATE VIEW q1iv(birthyear, avgheight, count)
AS
  SELECT birthyear, avg(height), count(*)
  FROM people
  GROUP BY birthyear
  HAVING avg(height) > 70 
  ORDER BY birthyear
;

-- Question 2i
CREATE VIEW q2i(namefirst, namelast, playerid, yearid)
AS
  SELECT people.namefirst, people.namelast, people.playerid, HallofFame.yearid
  FROM people, HallofFame
  WHERE people.playerid = HallofFame.playerid and HallofFame.inducted = 'Y'
  ORDER BY HallofFame.yearid DESC
;

-- Question 2ii
CREATE VIEW q2ii(namefirst, namelast, playerid, schoolid, yearid)
AS
  SELECT hof.namefirst, hof.namelast, hof.playerid, school.schoolid, hof.yearid
  FROM 
      (SELECT people.namefirst, people.namelast, people.playerid, HallofFame.yearid
      FROM people, HallofFame
      WHERE people.playerid = HallofFame.playerid and HallofFame.inducted = 'Y'
      ORDER BY HallofFame.yearid DESC) as hof, 
      (SELECT s.*, c.playerid
      FROM schools s, collegeplaying c
      WHERE c.schoolid = s.schoolid and s.schoolstate = 'CA') as school
  WHERE hof.playerid = school.playerid
  ORDER BY hof.yearid desc, school.schoolid, hof.playerid;
;

-- Question 2iii
CREATE VIEW q2iii(playerid, namefirst, namelast, schoolid)
AS
  SELECT hof.playerid, hof.namefirst, hof.namelast, collegeplaying.schoolid
  FROM 
      (SELECT people.playerid, people.namefirst, people.namelast, HallofFame.yearid
      FROM people, HallofFame
      WHERE people.playerid = HallofFame.playerid and HallofFame.inducted = 'Y'
      ORDER BY HallofFame.yearid DESC) as hof
  LEFT JOIN CollegePlaying
  ON hof.playerid = collegeplaying.playerid
  ORDER BY hof.playerid desc, collegeplaying.schoolid
;

-- Question 3i
CREATE VIEW q3i(playerid, namefirst, namelast, yearid, slg)
AS
SELECT people.playerid, people.namefirst, people.namelast, slug.yearid, slug.tot as slg
FROM people,
  (SELECT *, CAST(((h-h2b-h3b-hr) + 2.0*h2b + 3.0*h3b + 4.0*hr)/ab as float) as tot
  FROM batting 
  WHERE ab > 50) as slug 
WHERE people.playerid = slug.playerid
ORDER BY tot desc, slug.yearid, people.playerid
LIMIT 10
;

-- Question 3ii
CREATE VIEW q3ii(playerid, namefirst, namelast, lslg)
AS
SELECT people.playerid, people.namefirst, people.namelast, slug.lslg
FROM people, 
  (SELECT playerid, CAST( sum(((h-h2b-h3b-hr) + 2.0*h2b + 3.0*h3b + 4.0*hr))/ sum(ab) as float) lslg, sum(ab) as ab
  FROM batting
  GROUP BY playerid) as slug
WHERE people.playerid = slug.playerid and ab > 50
ORDER BY lslg desc, people.playerid
LIMIT 10
;

-- Question 3iii
CREATE VIEW q3iii(namefirst, namelast, lslg)
AS
  WITH slgs AS (SELECT playerid, yearid, CAST((h - h2b - h3b - hr + (2*h2b) + (3*h3b) + (4*hr)) AS FLOAT) AS tot, ab AS tab from batting),
  tots AS (SELECT playerid, SUM(tot) AS hits, SUM(tab) AS bats FROM slgs GROUP BY playerid HAVING SUM(tab)>50),
  life AS (SELECT s.playerid, p.namefirst, p.namelast, CAST(s.hits AS FLOAT)/s.bats AS life FROM tots as s, people as p WHERE s.playerid = p.playerid)
  SELECT l.namefirst, l.namelast, l.life as lslg
  FROM life as l
  WHERE l.life > ALL (SELECT l2.life from life AS l2 WHERE l2.playerid = 'mayswi01')
  ORDER BY l.namefirst
;

-- Question 4i
CREATE VIEW q4i(yearid, min, max, avg, stddev)
AS
  SELECT yearid, MIN(salary), MAX(salary), AVG(salary), stddev(salary)
  FROM salaries
  GROUP BY yearid
  ORDER BY yearid
;

-- -- Question 4ii
-- CREATE VIEW q4ii(binid, low, high, count)
-- AS with temp(low, high) as (select min(salary), max(salary) from salaries)
-- SELECT 
--   FLOOR((salary - low)/ ((high-low)/10), 9)
-- FROM salaries, temp
-- ;

-- Question 4iii
CREATE VIEW q4iii(yearid, mindiff, maxdiff, avgdiff)
AS with
  s as (select yearid, min(salary) mindiff, max(salary) maxdiff, avg(salary) avgdiff from salaries group by yearid)
select s1.yearid, s1.mindiff - s2.mindiff as mindiff, s1.maxdiff - s2.maxdiff as maxdiff, s1.avgdiff - s2.avgdiff as avgdiff
from s as s1 left join s as s2
on s1.yearid = s2.yearid + 1 
where s1.yearid != 1985
order by yearid
;

-- Question 4iv
CREATE VIEW q4iv(playerid, namefirst, namelast, salary, yearid)
AS with temp0(m0) as (select max(salary) from salaries where yearid = 2000), 
    temp1(m1) as (select max(salary) from salaries where yearid = 2001)

  SELECT people.playerid, people.namefirst, people.namelast, salaries.salary, salaries.yearid
  FROM salaries, temp0, temp1, people
  WHERE ((salaries.salary = temp0.m0 and salaries.yearid = 2000) or (salaries.salary = temp1.m1 and salaries.yearid = 2001)) 
  and (people.playerid = salaries.playerid)
;
-- Question 4v
CREATE VIEW q4v(team, diffAvg) AS
WITH star AS 
  (select a.teamid as team, max(salary) - min(salary) as dif, CASE WHEN count(*) <= 1 THEN 1 WHEN count(*) > 1 THEN 2 END AS "num" from salaries, AllStarFull as a where salaries.yearid = 2016 and a.yearid = 2016 and salaries.playerid = a.playerid group by a.teamid) 
select team, dif as diffAvg
from star
order by team
;
