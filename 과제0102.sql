# 문제
# - BBK 가 구매한 데이터를 출력하시요
# - 김씨인 사람 중 이름과 키를 기준으로 이름, 키 주소를 내림차순으로 출력
#  (  이름 뒤에는 '님' 을 붙여서 출력 )
# - user 를 출생년도별 오름차순으로 이름, 주소, 키 , 출생년도를 출력하시요
# ( 이름은 성을 뺴고 출력)
# - 모바일 번호가 011 로 시작하는 사람이 몇명인지 출력하시요
# - 출생년도가 1960 년에서 1979 년까지 태어난 사람들이 구매한 품목을 출력하시요
# - userID 별로 구매한 price, amount 합계를 출력하시요(이때 userID 는 name 으로 출력)
#- 주소가 서울인 사람이 구매한 총액을 구하라
#- 품목별 판매총액을 출력하라
#- 출생년도가 1970년도 이상인 사람을 대상으로 구매한 갯수가 2개 이상인 것의 판매 총합계를 구하라
# 모든 유저를 출력하라(이름 중에 김씨와 조씨는 모두 컬씨로 바꾸어 출력)
# 책을 구매한 사람의 이름과 출생년도와 주소를 출력하시오.




INSERT INTO user VALUES('BBK','바비킴',1973,'서울','010','0000000',176,'2013-05-05'); 
INSERT INTO user VALUES('EJW','은지원',1972,'경북','011','8888888',174,'2014-03-03');
INSERT INTO user VALUES('JKW','조관우',1965,'경기','018','9999999',172,'2010-10-10');
INSERT INTO user VALUES('JYP','조용필',1950,'경기','011','4444444',166,'2009-04-04');
INSERT INTO user VALUES('KBS','김범수',1979,'경남','011','2222222',173,'2012-04-04');
INSERT INTO user VALUES('KKH','김경호',1971,'전남','019','3333333',177,'2007-07-07');
INSERT INTO user VALUES('LJB','임재범',1963,'서울','016','6666666',182,'2009-09-09');
INSERT INTO user VALUES('LSG','이승기',1987,'서울','011','1111111',182,'2008-08-08');
INSERT INTO user(userID,NAME,birthYear,addr,height,mDate) 
	VALUES('SSK','성시경',1979,'서울',186,'2013-12-12');
INSERT INTO user(userID,NAME,birthYear,addr,height,mDate) 
	VALUES('YJS','윤종신',1969,'경남',170,'2005-05-05')

SELECT * FROM user

INSERT INTO buylist(userID,prodName,groupName,price,amount)
	 VALUES('KBS','운동화','전자',30,2);
INSERT INTO buylist(userID,prodName,groupName,price,amount) 
	VALUES('KBS','노트북','전자',1000,1);
INSERT INTO buylist(userID,prodName,groupName,price,amount) 
	VALUES('JYP','모니터','전자',200,1);
INSERT INTO buylist(userID,prodName,groupName,price,amount) 
	VALUES('BBK','모니터','전자',200,5);
INSERT INTO buylist(userID,prodName,groupName,price,amount) 
	VALUES('KBS','청바지','의류',50,3);
INSERT INTO buylist(userID,prodName,groupName,price,amount) 
	VALUES('BBK','메모리','전자',80,10);
INSERT INTO buylist(userID,prodName,groupName,price,amount)
	VALUES('SSK','책','서적',15,5);
INSERT INTO buylist(userID,prodName,groupName,price,amount)
	VALUES('EJW','책','서적',15,2);
INSERT INTO buylist(userID,prodName,groupName,price,amount)
	VALUES('EJW','청바지','의류',50,1);
INSERT INTO buylist(userID,prodName,groupName,price,amount)
	VALUES('BBK','운동화','전자',30,2);
INSERT INTO buylist(userID,prodName,groupName,price,amount)
	VALUES('EJW','책','서적',15,1);
INSERT INTO buylist(userID,prodName,groupName,price,amount)
	VALUES('BBK','운동화','서적',30,2);

SELECT * FROM buylist;


# 1번 : BBK가 구매한 데이터를 출력하시요 
SELECT us.userID, bu.prodName
	FROM user us INNER JOIN buylist bu
		ON us.userID = bu.userID AND us.userID="BBK";



# 2번 : 김씨인 사람 중 이름과 키를 기준으로 /이름, 키 주소를 내림차순으로 출력하시요
#     ( 이름 뒤에는 '님'을 붙여서 출력)
SELECT concat(NAME,'님') AS name, height, addr FROM user where NAME LIKE '김%' ORDER BY NAME, height DESC;


#3번 : user를 출생년도별 오름차순으로 이름, 주소, 키, 출생년도를 출력하시요
#     ( 이름은 성을 빼고 출력) 

SELECT SUBSTR(NAME,2,3) AS NAME , addr, height, mDate FROM user
	ORDER BY birthYear;
	
# 4번 : 모바일 번호가 011로 시작하는 사람이 몇명인지 출력하시요 
SELECT COUNT(*) FROM user WHERE mobile1='011';



# 5번: 출생년도가 1960년에서 1979년까지 태어난 사람들이 구매한 품목을 출력하시요 
SELECT us.userID, us.birthYear, bu.prodName
	FROM user us INNER JOIN buylist bu
		ON us.userID = bu.userID AND us.birthYear BETWEEN 1960 AND 1979;
		
#6번 : UserID별로 구매한 price, amount합계를 출력하시요 
# ( 이 때 userID는 name으로 출력하시요 )
SELECT us.name, bu.price, SUM(bu.amount)
	FROM user us INNER JOIN buylist bu
		ON us.userID = bu.userID GROUP BY us.userID;
	
# select name, total from student where schoolcode in (select schoolcode from school where schoolname="충주여자고등학교");
# 7번 : 주소가 서울인 사람이 구매한 총액을 구하시요
SELECT us.addr, SUM( bu.price * bu.amount)
	FROM user us INNER JOIN buylist bu
		ON us.userID = bu.userID AND us.addr="서울";
		
# 8번 : 품목별 판매 총액을 출력하시요 
SELECT groupName, SUM(price*amount) FROM buylist GROUP BY groupName;

#9번 :  출생년도가 1970년도 이상인 사람을 대상으로 구매한 갯수가
#       2개 이상인 것의 판매 총합계를 구하시요 

SELECT  SUM(price*amount) FROM buylist WHERE amount>=2 AND 
userID IN (SELECT userID FROM user WHERE birthYear>=1970);

# 10번 : 모든 유저를 출력하시요
# (이름 중에 김씨와 조씨는 모두 컬씨로 바꾸어 출력)




		
# 11번 : 책을 구매한 사람의  이름과 출생년도와 주소를 출력하시요 
SELECT NAME, birthYear, addr FROM user WHERE userID 
	IN (SELECT userID FROM buylist WHERE groupName="서적");
	
	
	
