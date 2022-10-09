go
--drop database SWP391
CREATE DATABASE [SWP391]
go
use [SWP391]
CREATE TABLE userCommon(
userID int identity(1,1) primary key,
name nvarchar(50),
password  nvarchar(50),
email nvarchar(100) unique,
dob date,
sex int,
address nvarchar(200),
phone nvarchar(12) unique,
imgAvt nvarchar(1000) default 'https://iupac.org/wp-content/uploads/2018/05/default-avatar.png',
description nvarchar(1000) default '',
status nvarchar(1000),
moneyLeft int default 0,
createTime datetime default getDate(),
/*1 is mentor, 2 is mentee*/
role int,
)
CREATE TABLE mentor(
userID int primary key,
foreign key (userID) references userCommon(userID),
education nvarchar(200) default '',
yearExperiment int default 0,
intro nvarchar(1000) default '',
imgAuthen1 nvarchar(1000),
imgAuthen2 nvarchar(1000),
authen int default 0,
)
CREATE TABLE mentee(
userID int primary key,
foreign key (userID) references userCommon(userID),
)

CREATE TABLE subject(
subjectID int identity(1,1) primary key,
subjectName nvarchar(100),
level nvarchar(100),
status nvarchar(1000),
)

CREATE TABLE request(
requestID int identity(1,1) primary key,
userID int,
foreign key (userID) references userCommon(userID),
subjectID int,
foreign key (subjectID) references subject(subjectID),
moneyPerSlot int,
timePerSlot int,
startTime datetime,
endTime datetime,
description nvarchar(1000) default '',
--0 is destroy, 1 is display, 2 is learning
status int,
/*1 is off, 2 is onl*/
learnType int,
reqTime datetime default getDate()
)
CREATE TABLE requestSlotTime(
requestID int,
foreign key (requestID) references request(requestID),
slotFrom datetime,
slotTo datetime
)
CREATE TABLE course(
courseID int identity(1,1) primary key,
subjectID int,
foreign key (subjectID) references subject(subjectID),
mentorID int,
foreign key (mentorID) references mentor(userID),
slots int,
timePerSlot int,
moneyPerSlot int,
timeStart date,
timeEnd date,
/*1 is off, 2 is onl*/
learnType int,
status int,
description nvarchar(1000) default '',
createTime datetime default getDate(),
)
create table requestsCourse(
courseID int,
foreign key (courseID) references course(courseID),
requestID int,
foreign key (requestID) references request(requestID),
--1 is mentee request, mentor ask to teach, 2 is mentor request, mentees ask to study
[type] int,
)
create table wishRequest(
requestMenteeID int,
requestMentorID int,
foreign key (requestMenteeID) references request(requestID),
foreign key (requestMentorID) references request(requestID),
)
CREATE TABLE major(
subjectID int,
foreign key (subjectID) references subject(subjectID),
mentorID int, 
foreign key (mentorID) references mentor(userID),
)

CREATE TABLE slot(
slotID int identity(1,1) primary key,
slotTimeFrom datetime,
slotTimeTo datetime,
courseID int,
foreign key (courseID) references course(courseID),
status int,
description nvarchar(1000) default '',
)


CREATE TABLE bill(
billID int identity(1,1) primary key,
courseID int,
foreign key (courseID) references course(courseID),
userID int,
foreign key (userID) references userCommon(userID),
amount int,
billDate datetime,
description nvarchar(1000),
/*1 - Mentee to web, 2 - Web to mentor*/
billType int,
status int,
createTime datetime default getDate()
)

CREATE TABLE rating(
rateID int identity(1,1) primary key,
rateAmount int,
rateDescription nvarchar(1000),
rateTime datetime default getDate(),
mentorID int,
foreign key (mentorID) references mentor(userID),
menteeID int,
foreign key (menteeID) references mentee(userID),
)

CREATE TABLE notification(
notiID int identity(1,1) primary key,
userID int, 
foreign key (userID) references userCommon(userID),
content nvarchar(1000),
/*ex: 1 is message, 2 is new request, 3 is money...*/
notiType int,
status int,
notiTime datetime default getDate(),
)
CREATE TABLE admin(
id int identity(1,1) primary key,
username nvarchar(100),
password nvarchar(100),
role int,
description nvarchar(1000),
)

CREATE TABLE authenticationCode(
id int identity(1,1) primary key,
email nvarchar(100),
code nvarchar(10),
createTime datetime default getDate(),
)
create table conversation(
conversationID int identity(1,1) primary key,
userID1 int,
userID2 int,
foreign key (userID1) references userCommon(userID),
foreign key (userID2) references userCommon(userID),
createTime datetime default getDate(),
)
create table message(
messageID int identity(1,1) primary key,
conversationID int,
sender int,
foreign key (sender) references userCommon(userID),
receiver int,
foreign key (receiver) references userCommon(userID),
content nvarchar(1000),
status int,
foreign key (conversationID) references conversation(conversationID),
createTime datetime default getDate(),
)
create table adminAction(
adminID int,
foreign key (adminID) references admin(id),
action nvarchar(1000),
createTime datetime default getDate(),
)
ALTER table requestSlotTime add [day] int
ALTER TABLE requestSlotTime
ALTER COLUMN slotFrom time;
ALTER TABLE requestSlotTime
ALTER COLUMN slotTo time;

