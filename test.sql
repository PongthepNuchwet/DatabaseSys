SELECT * FROM  reserves R, boats B WHERE R.bid = B.bid;
SELECT *,COUNT(R.sid) FROM reserves R RIGHT JOIN boats B ON R.bid = B.bid;

SELECT S.rating, MIN(S.age) FROM sailors S WHERE S.age >= 18 GROUP BY S.rating;
SELECT S.sname ,S.rating, MIN(S.age) FROM sailors S WHERE S.age > 18 GROUP BY S.rating;

SELECT S.rating, MIN(S.age), COUNT(*) FROM sailors S WHERE S.age >= 18 GROUP BY S.rating HAVING COUNT(*) > 1;
SELECT * FROM sailors S WHERE S.rating = 3 ;

SELECT S.side, S.sname  FROM sailors S , reserves R, boats B  WHERE S.sid = R.sid AND R.bid = B.bid AND B.color = 'red' ;
