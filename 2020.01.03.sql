-- --------------------------------------------------------
-- 호스트:                          192.168.1.249
-- 서버 버전:                        5.5.64-MariaDB - MariaDB Server
-- 서버 OS:                        Linux
-- HeidiSQL 버전:                  10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- acconschool 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `acconschool` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `acconschool`;

-- 테이블 acconschool.pet 구조 내보내기
CREATE TABLE IF NOT EXISTS `pet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `owner` varchar(20) DEFAULT NULL,
  `species` varchar(20) DEFAULT NULL,
  `sex` char(1) DEFAULT NULL,
  `birth` date DEFAULT NULL,
  `death` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- 테이블 데이터 acconschool.pet:~7 rows (대략적) 내보내기
/*!40000 ALTER TABLE `pet` DISABLE KEYS */;
INSERT INTO `pet` (`id`, `name`, `owner`, `species`, `sex`, `birth`, `death`) VALUES
	(3, '들이', 'acorn', '곰', 'f', '2014-08-01', '2018-02-01'),
	(4, '대한', '민주', 'cat', 'f', '2001-02-04', NULL),
	(5, '민국', '자유', 'cat', 'f', '2010-03-17', NULL),
	(6, '만세', '민주', 'cat', 'f', '2010-05-13', NULL),
	(7, '하자', '민주', 'cat', 'm', '2015-08-27', NULL),
	(8, '성공', '자유', 'cat', 'm', '2017-08-31', '2018-04-29'),
	(12, '마음', 'acorn', '백구', 'f', '2018-01-02', '2018-11-04');
/*!40000 ALTER TABLE `pet` ENABLE KEYS */;

-- 프로시저 acconschool.pet_delete 구조 내보내기
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `pet_delete`(
	IN `inname` VARCHAR(50),
	OUT `res` INT
)
BEGIN
	DECLARE cnt INT DEFAULT 0;
	SELECT COUNT(*) INTO cnt from pet WHERE NAME = inname;  # count 에 나온값을 cnt 에 넣는다. 
	if cnt > 0 then DELETE FROM pet WHERE NAME = inname;
		set res = 0;
	ELSE SET res = 2;
	END if;
END//
DELIMITER ;

-- 프로시저 acconschool.pet_insert 구조 내보내기
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `pet_insert`(
	IN `name` VARCHAR(50),
	IN `owner` VARCHAR(50),
	IN `species` VARCHAR(50),
	IN `sex` CHAR(1),
	IN `birth` DATE,
	IN `death` DATE


)
BEGIN
	insert into pet(name, owner, species, sex, birth, death)  # 이건 필드이름
	values (name, owner,species,sex,birth,death);  # 이건 변수이름 
END//
DELIMITER ;

-- 프로시저 acconschool.pet_select 구조 내보내기
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `pet_select`()
BEGIN
	select * from pet;
END//
DELIMITER ;

-- 프로시저 acconschool.pet_update 구조 내보내기
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `pet_update`(
	IN `searchname` VARCHAR(50),
	IN `updatename` VARCHAR(50),
	OUT `res` INT
)
BEGIN
	DECLARE cnt INT DEFAULT 0; # CNT=0 이고 INT 형을 만들라는 의미이다.
	SELECT COUNT(*) INTO cnt FROM pet WHERE NAME = searchname; # 같은 놈이 있으면 count 가 올라감
	IF cnt > 0 then UPDATE pet SET NAME = updatename 
		WHERE NAME = searchname;
		SET res = 0;  # 변수에 값을 넣을땐 SET 필수!
	ELSE SET res = 2; # res 를 이용해서 정상이면 0을 return 없는 것이면 res =1 을 return 한다. 
	END if ; 
END//
DELIMITER ;

-- 테이블 acconschool.sungjuk 구조 내보내기
CREATE TABLE IF NOT EXISTS `sungjuk` (
  `bunho` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `kor` int(11) DEFAULT NULL,
  `mat` int(11) DEFAULT NULL,
  `eng` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `average` float DEFAULT NULL,
  `grade` char(1) DEFAULT NULL,
  PRIMARY KEY (`bunho`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 acconschool.sungjuk:~1 rows (대략적) 내보내기
/*!40000 ALTER TABLE `sungjuk` DISABLE KEYS */;
/*!40000 ALTER TABLE `sungjuk` ENABLE KEYS */;

-- 프로시저 acconschool.sungjuk_delete 구조 내보내기
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `sungjuk_delete`(
	IN `in_name` VARCHAR(50),
	OUT `out_res` INT

)
BEGIN
	DECLARE cnt int default 0;
	select count(*) into cnt from sungjuk where name = in_name;
	if cnt > 0 then delete from sungjuk where name = in_name;
		set out_res = 0;
	else set out_res :=2;
	end if;
END//
DELIMITER ;

-- 프로시저 acconschool.sungjuk_insert 구조 내보내기
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `sungjuk_insert`(
	IN `in_name` VARCHAR(50),
	IN `in_kor` INT,
	IN `in_mat` INT,
	IN `in_eng` INT
)
BEGIN
	insert into sungjuk(name, kor, mat, eng)
	values(in_name, in_kor, in_mat, in_eng);
END//
DELIMITER ;

-- 프로시저 acconschool.sungjuk_select 구조 내보내기
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `sungjuk_select`()
BEGIN
	select * from sungjuk;
END//
DELIMITER ;

-- 프로시저 acconschool.sungjuk_update 구조 내보내기
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `sungjuk_update`(
	IN `in_name` VARCHAR(50),
	IN `up_name` VARCHAR(50),
	OUT `out_res` INT

)
BEGIN
	DECLARE cnt int default 0;
	select count(*) into cnt from sungjuk where name = in_name;
	if cnt > 0 then update sungjuk set name =up_name where name = in_name;
		set out_res :=0;
	else set out_res :=2;
	end if;
# 매개변수 5개일때 
#	if cnt > 0 then update sungjuk set name =up_name, kor=in_kor,
#		mat = in_mat, eng= in_eng where name = in_name;
#		set out_res :=0;
#	else set out_res :=2;
#	end if;
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
