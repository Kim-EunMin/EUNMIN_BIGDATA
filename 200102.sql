#2020.01.02

INSERT INTO goods VALUES(1,"냉장고",2,850000);
INSERT INTO goods VALUES(2,"세탁기",3,550000);
INSERT INTO goods VALUES(3,"전자레인지",2,350000);
INSERT INTO goods VALUES(4,"HDTV",3,1500000);
# 확인하고 싶으면 select 사용한다.
INSERT INTO goods(CODE, su, dan) VALUES(4,3,1500000);
INSERT INTO goods(NAME, su, dan) VALUES("py",3,1500000); 
 # 두 문장이 입력되지 않는 이유는? 
 # name 은 not null 이기 때문이다. code 는 primary key 이다. (기본값이 0, 중복이 되면 안된다)

SELECT * FROM goods;
INSERT INTO goods(CODE,NAME,su) VALUES(5,"드론",1);
UPDATE goods SET dan = 1000000 WHERE CODE = 5;  #중복없이 데이터 입력
SELECT * FROM goods;
DELETE FROM goods WHERE  CODE = 5
INSERT INTO goods VALUES(5,"VR 기",2,1440000);


# 필드명이 생략되면 values 에 값이 모두 들어가게 지정해야 한다. 
INSERT INTO goods VALUES(6,"Drone",1,890000);
# 3개만 넣고 싶으면 필드명 꼭 지정해야한다.
INSERT INTO goods(CODE, NAME, su) VALUES(7,"고성능컴퓨터",3);

# 데이터 베이스를 하는 이유는? 빅데이터는 데이터베이스에 있는 데이터를 다루기 때문이다. 


# Q. 이름이 냉장고이고 단가가 750000 이상인 데이터 출력
SELECT * FROM goods WHERE NAME = "냉장고" and dan>750000;
# 단가가 75000이하 제품 출력
SELECT * FROM goods WHERE dan < 750000;
# 판매수량이 3개 이상인제품명과 단가 출력
SELECT NAME, dan FROM goods WHERE su>=3;
# 단가가 50000 이상이고, 1200000 이하인 제품 출력
SELECT * FROM goods WHERE dan>50000 AND dan<1200000;








INSERT INTO student VALUES(20120001,"고길동","m",27,'선박','seoul','010-000-4512',5000);
INSERT INTO student VALUES(20120002,"최둘리","m",22,'역사','pusan','010-999-9999',4500);
INSERT INTO student VALUES(20120003,"도우너","w",15,'역사','daegu','010-555-5555',6500);
INSERT INTO student VALUES(20120004,"김만덕","w",15,'유아','mokpo','010-555-7777',7000);
INSERT INTO student VALUES(20120005,"류현진","m",22,'컴퓨터공학','seoul','010-122-222',8000);
INSERT INTO student VALUES(20120006,"손흥민","m",22,'컴퓨터공학','seoul','010-999-9999',8000);

SELECT * FROM student
# 직업별로 급여의 합계를 내시오
SELECT major,SUM(money) FROM student GROUP BY major;  # group by 뒤에 오는 것은 기준이다. 
SELECT COUNT(*) FROM student;  # 전체 수를 구하시오
# 최씨로 시작하는 사람 출력
SELECT * FROM student WHERE NAME LIKE '최%' ;  # 뒤에 퍼센트가 온다.

# 서울이 주소이고 고씨인 사람
SELECT * FROM student WHERE addr LIKE 'seoul' AND NAME LIKE '고%';

# 필드이름을 바꿔준다. (필드이름 지정할 때 as 는 붙여도 되고 안붙여도 되고 )
SELECT COUNT(*) "전체 행수", COUNT(money) "급여건수",
MAX(money) "최대급여", MIN(money) "최소급여",
ROUND(AVG(money),2) "평균급여" FROM student;

# 위랑 비교해보기
SELECT COUNT(*) , COUNT(money) ,
MAX(money) , MIN(money) ,
ROUND(AVG(money),2)  FROM student;

# min 값과 max 값의 차이를 통해 구간값을 구할 수 있다.
SELECT MAX(money) - MIN(money) AS 전체구간 FROM student;  # 필드이름 지정할 때 as 는 붙여도 되고 안붙여도 되고

# money 에 대하여 min-max 정규화를 실행하시요 
#--> 모든값에 min 값을 빼주고, 최대최소를 뺀값으로 나눠준다.
# 
# SELECT (money-MIN(money)) / (MAX(money)-MIN(money)) AS 정규화 FROM student; 
#76번처럼 하면 그룹 함수이기 때문에 그룹값을 상수화해야 정상적으로 계산됨.(즉 1번만 계산된다, 그러니 아래처럼 한다) 
 
# 프로그램으로 변경 (사용자 변수 @, 시스템변수는 @@)
 # money 의 작은값을 minvalue 에 집어넣어라

SELECT MIN(money) INTO @minvalue FROM student2;
SELECT @minvalue;
SELECT max(money) - MIN(money) INTO @rangevalue FROM student2;
SELECT @rangevalue;
SELECT (money- @minvalue)/@rangevalue AS 정규화값  FROM student2; 

# 지금까지 한 것은 students2 로 바꾸셨다. 

# student 가 school 을 참조하므로 school 의 데이터는 필수다.
# school 데이터를 치자 (쿼리로 이동) 
# school 을 채우자. 

INSERT INTO school(schoolname, address, schoolcode, studentcount) 
	VALUES("충주여자고등학교", "충주시", "CH00000001",300);
	
INSERT INTO school(schoolname, address, schoolcode, studentcount) 
	VALUES("신성여자고등학교", "제주시", "IC00000001",500);
	
INSERT INTO school(schoolname, address, schoolcode, studentcount) 
	VALUES("종로여자고등학교", "종로구", "JR00000001",300);
	
INSERT INTO school(schoolname, address, schoolcode, studentcount) 
	VALUES("제주여자고등학교", "서울시", "SE00000001",300);

SELECT * FROM school;


INSERT INTO student(NAME,kor,mat,eng,schoolcode)
	VALUES ("전공인",81,81,81,"SE00000001");
INSERT INTO student(NAME,kor,mat,eng,schoolcode)
	VALUES ("전공이",81,81,81,"SE00000001");
INSERT INTO student(NAME,kor,mat,eng,schoolcode)
	VALUES ("전공삼",91,100,100,"CH00000001");
INSERT INTO student(NAME,kor,mat,eng,schoolcode)
	VALUES ("전공사",100,100,100,"CH00000001");
INSERT INTO student(NAME,kor,mat,eng,schoolcode)
	VALUES ("고려인",100,100,100,"CH00000001");
INSERT INTO student(NAME,kor,mat,eng,schoolcode)
	VALUES ("종로구",100,81,71,"IC00000001");
INSERT INTO student(NAME,kor,mat,eng,schoolcode)
	VALUES ("종로구",100,81,71,"IC00000001");
	
SELECT * FROM student;student_before_insert
	
SELECT * FROM school WHERE schoolcode="CH00000001";
SELECT * FROM student WHERE NAME ='고려인';
SELECT NAME, kor, eng ,mat FROM student WHERE NAME ='전공인';
# as 를  이용해서 별칭을 준다. 
SELECT NAME AS '이름' , kor AS '국어', mat AS '수학' , eng AS '영어' FROM student WHERE NAME= "전공이";

#서브쿼리 : select 안에 select 가 들어간다.
# in 뒤의 괄호안이 먼저 실행 school 코드가 ch000001 인 것을 가져오고,
# 그 것들의 kor, mat ,eng 를 가져온다. 
SELECT NAME, kor, mat , eng FROM student WHERE schoolcode
	IN(SELECT schoolcode FROM school WHERE schoolcode = 'CH00000001');
		
SELECT NAME, kor, mat , eng FROM student WHERE schoolcode
	IN(SELECT schoolcode FROM school WHERE schoolname="신성여자고등학교");

SELECT NAME, kor, mat, eng FROM student WHERE schoolcode
	IN (SELECT schoolcode FROM school WHERE schoolname = '신성여자고등학교')
# 언더바 1개는 한글자 맵핑/ % 는 여러글자 매핑
SELECT NAME, kor, mat, eng FROM student WHERE NAME LIKE '전공%';
SELECT NAME, kor, mat, eng FROM student WHERE NAME LIKE '%공%';
SELECT NAME, kor, mat, eng FROM student WHERE NAME LIKE '_려_';
#3자인것중 가운데가 려 인것을ㅈ출력(무조건3자)
SELECT NAME, kor, mat, eng FROM student WHERE NAME LIKE '전공인%';	
	
	
SELECT * FROM student WHERE kor > 90 AND mat >90 AND eng >90;
SELECT * FROM student WHERE kor>90 OR mat>90 OR eng>90;
SELECT * FROM student WHERE kor>80 AND kor<90;
SELECT * FROM student WHERE kor BETWEEN 80 AND 100;


# select 에는 group by, having, order by, limit 가 들어간다
SELECT * FROM student LIMIT 1;
# 전체를 가져오는데 1개만 가져온다.

SELECT * FROM student ORDER BY NAME DESC;
# DESC : 내림차순 
SELECT * FROM student ORDER BY NAME ASC; # 오름차순

# 이너 조인 : 2개의 조건이 만족하는 것을 출력한다. 
SELECT sc.schoolname, sc.schoolcode, st.name, st.average
	FROM student st INNER join school sc  # 왼쪽의 student 와 school 을 이너조인한다. (student 의 별칭은 sc,
	# school 의 별칭 sc 이다.  # 이너조인 : 외래키로 연결되어 있어야 가능(빅데이터딥러닝에서는 안해도됨)
		ON st.schoolcode = sc.schoolcode;
		#d이너조인에서 스튜던드의 schooolcode 와 schoool의 schoolcode 같은것을 출력하는데
		#sc.schoolname, sc.schoolcode, st.name, st.average 들만 출력하라.
		
# outer join/ left join / right join 도 있다.


SELECT NAME AS '이름', kor AS '국어', mat AS '수학', eng AS '영어'
	FROM student WHERE NAME='전공이';
	
SELECT CONCAT(NAME, '님') AS '이름', kor AS '국어', mat AS '수학',
	eng AS '영어' FROM student WHERE NAME='전공인';
# concat 은 합치는 것, name 이 있으면 님을 붙여서 출력하라(문자열결합함수 = concat)

SELECT CONCAT(NAME,'님') AS "이름", LPAD(kor, 10,"*") AS "국어",
	mat AS "수학", eng AS "영어" FROM student WHERE NAME = '전공삼';
#LPAD ( kor 왼쪽에 10자리를 만들어두고, * 를 채워라)

SELECT REPLACE(CONCAT(NAME,"님"),"님","형") AS "이름", LPAD(kor, 10, "*")
	AS '국어', mat AS '수학', eng AS '영어'
	FROM student WHERE NAME='전공삼';
	# replace : 님을 다시 형으로 바꿔라.
	
SELECT SUBSTR(REPLACE(CONCAT(NAME,"님"),"님","형"),1,2) AS "이름", 
	LPAD(kor,10,"*") AS "국어", mat AS "수학", eng AS "영어" 
		FROM student WHERE NAME='김종호';
	# substr : 원하는 데이터만 빼내라. 	substr(...,1,22 )d이므로 1~2번을 뺴내라. 
	
SELECT LENGTH(SUBSTR(REPLACE(CONCAT(NAME,'님'),"님","형"),1,2)) AS "이름",
	LPAD(kor,10,"*") AS "국어", mat AS "수학", eng AS "영어" 
		FROM student WHERE NAME="김종호";
	
	# length 가 길이(한글은 3바이트여서 6이 나온다) 
	
	
# 문제
# -- 1.전공인의 국어: 80, 영어: 90 으로 변경하고 합계와 평균 그리고 grade 를 수정
#   --  계산 을 수동으로 하고 변화만 적용하시요 
         #(update 명령을 써봐라. 업데이트3개하거나 또는 트리거로 한번에 하거나)
# -- 2.student 중 kor, mat 점수만 출력하시오
# -- 3.student 중 average 가 90 이상인 사람의 name, schoolname 을 출력하시오
# -- 4.student 중 eng 점수를 출려하되 그 이름을 '영어'  로 하시오
# -- 5.이름 가운데 자가 ' 공' 인 사람을 모두 출력하시오
# -- 6.학교 이름이 충주 여자 고등학교인 사람의 name 과 total 을 출력하시오
# -- 7. student 에서 total 을 이용하여 정렬하고 상위 2사람만 출력하시오


# 1번
UPDATE student SET kor=80, eng=90 WHERE NAME="전공인";
UPDATE student SET total = 251, average = 251/3, grade = 'B' WHERE NAME="전공인";
SELECT * FROM student;

## 선생님1번
UPDATE student SET eng=90 kor=80 WHERE NAME="전공인";
#합계나 평균 성적은 trigger 가 적용이 안된다. 수동으로 넣는다.
UPDATE student SET total = 90+80+90, average = ROUND((90+80+90)/3,2), grade = 'B' WHERE NAME="전공인";
# 또는
UPDATE student SET total = kor+mat+eng, average = ROUND((kor+mat+eng)/3,2), 
		grade = 
(Case When average>=90 THen 'A'
	When (average>=80 AND average<90) then 'B'
	When (average>=70 AND average<80) then 'C'
	When (average>=60 AND average<70) then 'D'
	ELSE 'F학점'
	END) # End 써줘야한다. 
		WHERE NAME="전공인";
#3번쨰 방법은 트리거 새로만들기 , 복사붙여넣기 해서 update 로 설정하면 됨.


UPDATE student SET total = kor+mat+eng, average = ROUND((kor+mat+eng)/3,2), 
		grade = 
(Case When average>=90 THen 'A'
	When (average>=80 AND average<90) then 'B'
	When (average>=70 AND average<80) then 'C'
	When (average>=60 AND average<70) then 'D'
	ELSE 'F학점'
	END) # End 써줘야한다. 
		WHERE NAME="전공인";


# 2번
SELECT kor, mat FROM student ;
	
# 3번
SELECT st.NAME, sc.schoolname 
	FROM student as st INNER JOIN school as sc
		 on st.average >= 90;
 
# 3번선생님답
SELECT st.NAME, sc.schoolname 
	FROM student as st INNER JOIN school as sc
		 on st.average >= 90 AND st.schoolcode=sc.schoolcode;  # 스쿨코드 같다고도 써야함.

# 4번
SELECT eng "영어" FROM student;

#5번
SELECT * FROM student WHERE NAME LIKE '%공%';

# 6번 : 학교 이름이 충주 여자 고등학교인 사람의 name 과 total 을 출력하시오
SELECT st.name, st.total
	FROM student st INNER JOIN school sc
		ON sc.schoolname = "충주여자고등학교"
		AND st.schoolcode=sc.schoolcode;  # 이것도 출력해야한다. 
 # 이렇게 하는 것보다 저장루틴이 편하다. (메모장)
 #select 안에 select 사진
#7번
SELECT * FROM student ORDER BY total DESC LIMIT 2;


# where, group by, having (group by 의 조건이 having 이다) ,order by , limit 순으로 와야한다. 


# 저장프로시져 연습
CALL student_select();

CALL student_insert("제주도",100,100,100,"TT00000001", @res);
SELECT @res;  # tt 가 없으니 -1이 나온다.,  @res 는 result 나오라고 쓴 것
             # student 의 schoolcode 는  school 이랑 외래키로 연결되었다. (school 에 TT 가 없어서 안됨)


CALL student_select();
##  call 하는 것은 서버측에서 테스트 하는 것이다. 

CALL student_insert("제주도",100,100,100,"IC00000001",@res);
SELECT @res;  #IC 는 있는 값 이여서 생성 가능
CALL student_select();


# 문제
# 이름을 변경하는 프로시저를 만드시오.(제[주도를 제주인으로 바꾼다)
 #student_updatename 라는  저장루틴만들기
  # 매개변수 name1(바꿀이름), name2(바뀐이름), result 만든다. 
CALL student_update_name("제주도","제주민",@res);
select @res;
CALL student_select();



# student_sum 저장루틴만들기

CALL student_sum();



#student_updateone 이라는 저장루틴 만들기(모든데이터에 1점씩 추가)
CALL student_updateone();
SELECT * FROM student;