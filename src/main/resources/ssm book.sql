USE `ssmbuild`;
Drop table if exists `books`;
CREATE TABLE `books`(
 `bookID` INT(10) not null auto_increment COMMENT '书id',
 `bookname` varchar(100) not null comment '书名',
 `bookcounts`  int(11) not null comment '数量',
 `detail` VARCHAR(200) not null comment '描述',
 key `bookid`(`bookid`)
)ENGINE=INNODB DEFAULT CHARSET=utf8;

INSERT into `books` (`bookID`,`bookname`,`bookcounts`,`detail`) VALUES
(1,'java',1,'从入门到放弃'),
(2,'mysql',18,'从删库到跑路'),
(3,'linux',12,'从进门到进牢');