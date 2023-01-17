-- (1) Find sailors who’ve reserves at least one boat
SELECT S.sid
FROM sailors S,
  reserves R
WHERE S.sid = R.sid;
--  sid 
-- -----
--   22
--   22
--   22
--   22
--   31
--   31
--   64
--   64
--   74
--   31
-- (10 rows)
-- (2) Find sid’s of sailors who’ve reserved a red “or” a green boat 
SELECT S.sid
FROM sailors S,
  boats B,
  reserves R
WHERE S.sid = R.sid
  AND R.bid = B.bid
  AND (
    B.color = 'red'
    OR B.color = 'green'
  );
;
--  sid
-- -----
--   22
--   22
--   22
--   31
--   31
--   64
--   74
--   31
-- (8 rows)
SELECT S.sid
FROM sailors S,
  boats B,
  reserves R
WHERE S.sid = R.sid
  AND R.bid = B.bid
  AND B.color = 'red'
UNION
SELECT S.sid
FROM sailors S,
  boats B,
  reserves R
WHERE S.sid = R.sid
  AND R.bid = B.bid
  AND B.color = 'green';
--  sid 
-- -----
--   74
--   31
--   22
--   64
-- (4 rows)
-- (3) Find names of sailors who’ve reserved boat #103: 
SELECT S.sname
FROM sailors S
WHERE S.sid IN (
    SELECT R.sid
    FROM reserves R
    WHERE R.bid = 103
  );
--   sname  
-- ---------
--  Dustin
--  Lubber
--  Horatio
-- (3 rows)
-- (4) EXISTS
SELECT S.sname
FROM sailors S
WHERE EXISTS (
    SELECT *
    FROM reserves R
    WHERE R.bid = 103
      AND S.sid = R.sid
  );
--   sname  
-- ---------
--  Dustin
--  Lubber
--  Horatio
-- (3 rows)
-- (5) Find sailors whose rating is greater than that of some sailor called Horatio 
SELECT *
FROM sailors S
WHERE S.rating > ANY (
    SELECT S2.rating
    FROM sailors S2
    WHERE S2.sname = 'Horatio'
  );
--  sid |  sname  | rating | age  
-- -----+---------+--------+------
--   31 | Lubber  |      8 | 55.5
--   58 | Rusty   |     10 | 35.0
--   71 | Zorba   |     10 | 16.0
--   74 | Horatio |      9 | 35.0
--   32 | Andy    |      8 | 25.5
-- (5 rows)
-- (6) Find sid’s of sailors who’ve reserved both a red and a green boat 
SELECT S.sid,
  S.sname
FROM sailors S,
  boats B,
  reserves R
WHERE S.sid = R.sid
  AND R.bid = B.bid
  AND B.color = 'red'
  AND S.sid IN (
    SELECT S2.sid
    FROM sailors S2,
      boats B2,
      reserves R2
    WHERE S2.sid = R2.sid
      AND R2.bid = B2.bid
      AND B2.color = 'green'
  );
--  sid | sname  
-- -----+--------
--   22 | Dustin
--   22 | Dustin
--   31 | Lubber
--   31 | Lubber
-- (4 rows)
SELECT S.sid
FROM sailors S,
  boats B,
  reserves R
WHERE S.sid = R.sid
  AND R.bid = B.bid
  AND B.color = 'red'
INTERSECT
SELECT S.sid
FROM sailors S,
  boats B,
  reserves R
WHERE S.sid = R.sid
  AND R.bid = B.bid
  AND B.color = 'green';
--  sid 
-- -----
--   31
--   22
-- (2 rows)
-- (7) Find sailors who’ve reserved all boats. 
SELECT S.sname
FROM sailors S
WHERE NOT EXISTS (
    (
      SELECT B.bid
      FROM boats B
    )
    EXCEPT (
        SELECT R.bid
        FROM reserves R
        WHERE R.sid = S.sid
      )
  );
--  sname  
-- --------
--  Dustin
-- (1 row)
SELECT S.sname
FROM sailors S
WHERE NOT EXISTS (
    SELECT B.bid
    FROM boats B
    WHERE NOT EXISTS (
        SELECT R.bid
        FROM reserves R
        WHERE R.bid = B.bid
          AND R.sid = S.sid
      )
  );
--  sname  
-- --------
--  Dustin
-- (1 row)
-- (8) Find name and age of the oldest sailor(s) 
SELECT S.sname,
  MAX(S.age)
FROM sailors S;
SELECT S.sname,
  S.age
FROM sailors S
WHERE S.age = (
    SELECT MAX (S2.age)
    FROM sailors S2
  );
--  sname | age  
-- -------+------
--  Bob   | 63.5
-- (1 row)
SELECT S.sname,
  S.age
FROM sailors S
WHERE (
    SELECT MAX (S2.age)
    FROM sailors S2
  ) = S.age;
--  sname | age  
-- -------+------
--  Bob   | 63.5
-- (1 row)
-- (9) Find the age of the youngest sailor with age ≥ 18, for each rating with at least 2 such sailors
SELECT MIN (S.age)
FROM sailors S
WHERE S.rating = 1;
--  min  
-- ------
--  33.0
-- (1 row)
SELECT MIN (S.age)
FROM sailors S
WHERE S.rating = 2;
--  min 
-- -----
-- (1 row)
SELECT MIN (S.age)
FROM sailors S
WHERE S.rating = 3;
--  min  
-- ------
--  25.5
-- (1 row)
SELECT MIN (S.age)
FROM sailors S
WHERE S.rating = 4;
--  min 
-- -----
SELECT MIN (S.age)
FROM sailors S
WHERE S.rating = 5;
--  min 
-- -----
-- (1 row)
SELECT S.*
FROM sailors S
WHERE S.age > 18;
--  sid |  sname  | rating | age  
-- -----+---------+--------+------
--   22 | Dustin  |      7 | 45.0
--   29 | Brutus  |      1 | 33.0
--   31 | Lubber  |      8 | 55.5
--   58 | Rusty   |     10 | 35.0
--   64 | Horatio |      7 | 35.0
--   74 | Horatio |      9 | 35.0
--   85 | Art     |      3 | 25.5
--   95 | Bob     |      3 | 63.5
--   32 | Andy    |      8 | 25.5
-- (9 rows)
SELECT S.rating,
  MIN(S.age)
FROM sailors S
WHERE S.age >= 18
GROUP BY S.rating;
--  rating | min  
-- --------+------
--       9 | 35.0
--       3 | 25.5
--      10 | 35.0
--       7 | 35.0
--       1 | 33.0
--       8 | 25.5
-- (6 rows)
SELECT S.rating,
  MIN(S.age),
  COUNT(*)
FROM sailors S
WHERE S.age >= 18
GROUP BY S.rating
HAVING COUNT(*) > 1;
--  rating | min  | count 
-- --------+------+-------
--       3 | 25.5 |     2
--       7 | 35.0 |     2
--       8 | 25.5 |     2
-- (3 rows)
SELECT S.rating,
  MIN(S.age)
FROM sailors S
WHERE S.age >= 18
GROUP BY S.rating
HAVING COUNT(*) > 1;
--  rating | min  
-- --------+------
--       3 | 25.5
--       7 | 35.0
--       8 | 25.5
-- (3 rows)
-- (10) For each red boat, find the number of reservations for this boat 
SELECT B.bid,
  COUNT (*) AS scount
FROM sailors S,
  boats B,
  reserves R
WHERE S.sid = R.sid
  AND R.bid = B.bid
  AND B.color = 'red'
GROUP BY B.bid;
--  bid | scount 
-- -----+--------
--  102 |      3
--  104 |      2
-- (2 rows)
-- (11) Find the age of the youngest sailor with age > 18, for each rating with at least 2 sailors (of any age) 
SELECT S.rating,
  MIN (S.age)
FROM sailors S
WHERE S.age > 18
GROUP BY S.rating
HAVING 1 < (
    SELECT COUNT (*)
    FROM sailors S2
    WHERE S.rating = S2.rating
  );
--  rating | min  
-- --------+------
--       3 | 25.5
--      10 | 35.0
--       7 | 35.0
--       8 | 25.5
-- (4 rows)
-- (12) CREATE young sailors table
CREATE TABLE IF NOT EXISTS public.young_sailors (
  sid integer NOT NULL,
  sname character varying(30),
  rating integer,
  age numeric(3, 1),
  CONSTRAINT young_sailors_sid_pkey PRIMARY KEY (sid),
  CONSTRAINT young_sailors_rating_check CHECK (
    rating >= 1
    AND rating <= 10
  )
);
-- CREATE TABLE
-- (13) Function 
-- FUNCTION: public.young_sailorsupdate()
-- DROP FUNCTION IF EXISTS public.young_sailorsupdate();
CREATE OR REPLACE FUNCTION public.young_sailorsupdate() RETURNS trigger LANGUAGE 'plpgsql' COST 100 VOLATILE NOT LEAKPROOF AS $BODY$ BEGIN
INSERT INTO young_sailors(sid, sname, rating, age)
VALUES(NEW.sid, NEW.sname, NEW.rating, NEW.age);
RETURN NEW;
END;
$BODY$;
ALTER FUNCTION public.young_sailorsupdate() OWNER TO postgres;
-- ALTER FUNCTION
-- (14) Trigger: young_sailors_trigger
-- DROP TRIGGER IF EXISTS young_sailors_trigger ON public.sailors;
CREATE TRIGGER young_sailors_trigger
AFTER
INSERT ON public.sailors FOR EACH ROW EXECUTE FUNCTION public.young_sailorsupdate();
-- CREATE TRIGGER
-- (15) Try to insert new sailors
INSERT INTO sailors (sid, sname, rating, age)
VALUES (111, 'Dang', 1, 30.5);
-- INSERT 0 1
SELECT sid,
  sname,
  rating,
  age
FROM young_sailors;
--  sid | sname | rating | age  
-- -----+-------+--------+------
--  111 | Dang  |      1 | 30.5
-- (1 row)
-- (16) Null
INSERT INTO young_sailors (sid, sname, rating, age)
VALUES (111, NULL, NULL, NULL);
-- ERROR:  duplicate key value violates unique constraint "young_sailors_sid_pkey"
-- DETAIL:  Key (sid)=(111) already exists.
SELECT sid,
  sname,
  rating,
  age
FROM young_sailors;
--  sid | sname | rating | age  
-- -----+-------+--------+------
--  111 | Dang  |      1 | 30.5
-- (1 row)
SELECT COUNT(*)
FROM young_sailors;
--  count 
-- -------
--      1
-- (1 row)
SELECT COUNT(sname)
FROM young_sailors;
--  count 
-- -------
--      1
-- (1 row)
SELECT COUNT(sid),
  COUNT(sname),
  COUNT(rating),
  COUNT(age)
FROM young_sailors;
--  count | count | count | count 
-- -------+-------+-------+-------
--      1 |     1 |     1 |     1
-- (1 row)
-- (17) CROSS JOIN
SELECT S.sid,
  R.bid
FROM sailors S
  CROSS JOIN reserves R;
--  sid | bid 
-- -----+-----
--   22 | 101
--   29 | 101
--   31 | 101
--   58 | 101
--   64 | 101
--   71 | 101
--   74 | 101
--   85 | 101
--   95 | 101
--   32 | 101
--  111 | 101
--   22 | 102
--   29 | 102
--   31 | 102
--   58 | 102
--   64 | 102
--   71 | 102
--   74 | 102
--   85 | 102
--   95 | 102
--   32 | 102
--  111 | 102
--   22 | 103
--   29 | 103
--   31 | 103
--   58 | 103
--   64 | 103
--   71 | 103
--   74 | 103
--   85 | 103
--   95 | 103
--   32 | 103
--  111 | 103
--   22 | 104
--   29 | 104
--   31 | 104
--   58 | 104
--   64 | 104
--   71 | 104
--   74 | 104
--   85 | 104
--   95 | 104
--   32 | 104
--  111 | 104
--   22 | 102
--   29 | 102
--   31 | 102
--   58 | 102
--   64 | 102
--   71 | 102
--   74 | 102
--   85 | 102
--   95 | 102
--   32 | 102
--  111 | 102
--   22 | 103
--   29 | 103
--   31 | 103
--   58 | 103
--   64 | 103
--   71 | 103
--   74 | 103
--   85 | 103
--   95 | 103
--   32 | 103
--  111 | 103
--   22 | 104
--   29 | 104
--   31 | 104
--   58 | 104
--   64 | 104
--   71 | 104
--   74 | 104
--   85 | 104
--   95 | 104
--   32 | 104
--  111 | 104
--   22 | 101
--   29 | 101
--   31 | 101
--   58 | 101
--   64 | 101
--   71 | 101
--   74 | 101
--   85 | 101
--   95 | 101
--   32 | 101
--  111 | 101
--   22 | 102
--   29 | 102
--   31 | 102
--   58 | 102
--   64 | 102
--   71 | 102
--   74 | 102
--   85 | 102
-- (18) INNER JOIN
SELECT S.sid,
  R.bid
FROM sailors S
  INNER JOIN reserves R ON (S.sid = R.sid);
--  sid | bid
-- -----+-----
--   22 | 101
--   22 | 102
--   22 | 103
--   22 | 104
--   31 | 102
--   31 | 103
--   31 | 104
--   64 | 101
--   64 | 102
--   74 | 103
-- (10 rows)
-- (19) LEFT OUTER JOIN
SELECT S.sid,
  R.bid
FROM sailors S
  LEFT OUTER JOIN reserves R ON (S.sid = R.sid);
--  sid | bid
-- -----+-----
--   22 | 101
--   22 | 102
--   22 | 103
--   22 | 104
--   31 | 102
--   31 | 103
--   31 | 104
--   64 | 101
--   64 | 102
--   74 | 103
--   71 |    
--   85 |    
--   32 |    
--   95 |    
--   29 |    
--   58 |    
--  111 |    
-- (17 rows)
SELECT S.sid,
  R.bid
FROM sailors S
  LEFT JOIN reserves R ON (S.sid = R.sid);
--  sid | bid
-- -----+-----
--   22 | 101
--   22 | 102
--   22 | 103
--   22 | 104
--   31 | 102
--   31 | 103
--   31 | 104
--   64 | 101
--   64 | 102
--   74 | 103
--   71 |    
--   85 |    
--   32 |    
--   95 |    
--   29 |    
--   58 |    
--  111 |    
-- (17 rows)
-- (20) RIGHT OUTER JOIN
SELECT S.sid,
  R.bid
FROM sailors S
  RIGHT OUTER JOIN reserves R ON (S.sid = R.sid);
--  sid | bid 
-- -----+-----
--   22 | 101
--   22 | 102
--   22 | 103
--   22 | 104
--   31 | 102
--   31 | 103
--   31 | 104
--   64 | 101
--   64 | 102
--   74 | 103
-- (10 rows)
SELECT S.sid,
  R.bid
FROM sailors S
  RIGHT JOIN reserves R ON (S.sid = R.sid);
--  sid | bid
-- -----+-----
--   22 | 101
--   22 | 102
--   22 | 103
--   22 | 104
--   31 | 102
--   31 | 103
--   31 | 104
--   64 | 101
--   64 | 102
--   74 | 103
-- (10 rows)
-- (21) FULL OUTER JOIN
SELECT S.sid,
  R.bid
FROM sailors S
  FULL OUTER JOIN reserves R ON (S.sid = R.sid);
--  sid | bid 
-- -----+-----
--   22 | 101
--   22 | 102
--   22 | 103
--   22 | 104
--   31 | 102
--   31 | 103
--   31 | 104
--   64 | 101
--   64 | 102
--   74 | 103
--   71 |    
--   85 |    
--   32 |    
--   95 |
--   29 |
--   58 |
--  111 |
-- (17 rows)
SELECT S.sid,
  R.bid
FROM sailors S
  FULL OUTER JOIN reserves R ON (S.sid = R.sid)
ORDER BY S.sid;
--  sid | bid 
-- -----+-----
--   22 | 103
--   22 | 102
--   22 | 104
--   22 | 101
--   29 |    
--   31 | 103
--   31 | 102
--   31 | 104
--   32 |    
--   58 |    
--   64 | 102
--   64 | 101
--   71 |
--   74 | 103
--   85 |
--   95 |
--  111 |
-- (17 rows)