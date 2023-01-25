-- Q11 Find all sailors with a rating above 7.
SELECT * FROM sailors WHERE sailors.rating > 7 ;

 sid |  sname  | rating | age  
-----+---------+--------+------
  31 | Lubber  |      8 | 55.5
  58 | Rusty   |     10 | 35.0
  71 | Zorba   |     10 | 16.0
  74 | Horatio |      9 | 35.0
  32 | Andy    |      8 | 25.5
(5 rows)


-- Q16, Q2 Find the sids and names of sailors who has reserved a read boat.
SELECT S.sid, S.sname  FROM sailors S JOIN reserves R ON S.sid = R.sid JOIN boats B  ON R.bid = B.bid WHERE B.color = 'red' ;
 sid 
-----
  22
  22
  31
  64
  31
(5 rows)

--Find sailors with ratting greater than the rating of at least one sailor called 'Horatio'
SELECT * FROM sailors S 
WHERE S.rating > ANY (SELECT S2.rating FROM sailors S2 WHERE S2.sname = 'Horatio');
 sid |  sname  | rating | age  
-----+---------+--------+------
  31 | Lubber  |      8 | 55.5
  58 | Rusty   |     10 | 35.0
  71 | Zorba   |     10 | 16.0
  74 | Horatio |      9 | 35.0
  32 | Andy    |      8 | 25.5
(5 rows)

--Find sailors with ratting greater than the rating of all 25.5 year old sailors 
SELECT *
FROM sailors S 
WHERE S.rating > ALL (SELECT S2.rating FROM sailors S2  WHERE S2.age = 25.5) ;
 sid |  sname  | rating | age  
-----+---------+--------+------
  58 | Rusty   |     10 | 35.0
  71 | Zorba   |     10 | 16.0
  74 | Horatio |      9 | 35.0
(3 rows)

--Find all sailors who have not reserved a red boat
SELECT S.sname
FROM sailors S 
LEFT JOIN (
  SELECT R.sid , R.bid , B.color 
  FROM reserves R
  INNER JOIN boats B ON (R.bid=B.bid)
  WHERE B.color = 'red'
  ) AS RB ON S.sid=RB.sid 
WHERE RB.color IS NULL ; 

-- Q17 Find the names of sailors whow have sailed two different boats on the same day.
SELECT S.sname FROM sailors S JOIN reserves R1 ON R1.sid = S.sid JOIN reserves R2 ON R2.sid = S.sid WHERE R1.sid = R2.sid AND R1.day = R2.day AND R1.bid <> R2.bid ;
;
 sname  
--------
 Dustin
 Dustin
(2 rows)

-- Q20 Find all sids of sailors who have a rating of 10 or reserved boat 104
SELECT S.sid FROM sailors S WHERE S.rating = 10 
UNION
SELECT R.sid FROM reserves R WHERE R.bid = 104 ;

SELECT S10.sid , R104.sid 
FROM (SELECT S.sid FROM sailors S WHERE S.rating = 10) S10 
FULL OUTER JOIN (SELECT r.sid FROM reserves r WHERE r.bid=104) R104 ON S10.sid=R104.sid ;

 sid 
-----
  31
  71
  22
  58
(4 rows)

-- Find name and age of the oldest sailor(s)
SELECT S.sname ,S.age FROM sailors S WHERE S.rating <= ALL (SELECT S2.rating FROM sailors S2) ;


-- The sailor with highest rating 
SELECT * FROM sailors S 
WHERE S.rating >= ALL (SELECT S2.rating FROM sailors S2) ;

SELECT * FROM sailors S 
WHERE S.rating = (SELECT MAX(S2.rating) FROM sailors S2) ;


-- Q30 Find the names of sailors who are older than the oldest sailor with a rating of 10
SELECT S.sname FROM sailors S WHERE S.age > (SELECT MAX(S2.age) FROM sailors S2 WHERE S2.rating=10 );

;
sname  
--------
 Dustin
 Lubber
 Bob
(3 rows)

-- Q31 Find the age of the youngest sailor for each rating level
SELECT S.rating , MIN(S.age) ,AVG(S.age)::numeric(3,1) FROM sailors S GROUP BY  S.rating ; 
 rating | min  | avg  
--------+------+------
      9 | 35.0 | 35.0
      3 | 25.5 | 44.5
     10 | 16.0 | 25.5
      7 | 35.0 | 40.0
      1 | 33.0 | 33.0
      8 | 25.5 | 40.5
(6 rows)

-- Find all pairs of sam-color bost 
SELECT B1.bname , B2.bname FROM boats B1 , boats B2 WHERE B1.color = B2.color AND B1.bname <> B2.bname ;
SELECT * FROM boats B1 INNER JOIN boats B2 ON B1.color = B2.color WHERE B1.bid <> B2.bid ;  

   bname   |   bname   
-----------+-----------
 Interlake | Marine
 Marine    | Interlake
(2 rows)

-- Find sailor who have reserved all boats 
SELECT S.sname 
FROM sailors S 
WHERE NOT EXISTS (SELECT B.bid 
                  FROM boats B 
                  WHERE NOT EXISTS (SELECT R.bid 
                                    FROM reserves R 
                                    WHERE R.bid = B.bid 
                                    AND R.sid = S.sid)) ;

 sname  
--------
 Dustin
(1 row)