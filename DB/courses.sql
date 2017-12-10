BEGIN TRANSACTION;
DROP TABLE IF EXISTS "courses";
CREATE TABLE "courses" ("course" VARCHAR PRIMARY KEY  NOT NULL  DEFAULT (null) ,"courseId" VARCHAR NOT NULL  DEFAULT (null) UNIQUE ,"department" VARCHAR NOT NULL ,"credits" INTEGER NOT NULL ,"prerequisite" VARCHAR,"instructor" VARCHAR NOT NULL ,"time" VARCHAR DEFAULT (null) ,"room" VARCHAR,"maxStudents" INTEGER,"studentsCount" INTEGER DEFAULT (0) ,"isOpen" BOOL,"level" VARCHAR,"cost" FLOAT DEFAULT (1350) );
INSERT INTO "courses" VALUES('oops in c language','CS001','computer science',3,'','sudheermende','','south101',60,5,'true','graduate',1350);
INSERT INTO "courses" VALUES('database management system','CS002','computer science',3,'','vinodh','','south102',60,4,'true','graduate',1350);
INSERT INTO "courses" VALUES('java and internet application','CS005','computer science',3,'cs001','adhi','','north101',60,2,'true','master',1500);
INSERT INTO "courses" VALUES('career development','GE001','general education',1,'','Gajvini','','north102',100,3,'true','graduate',1350);
INSERT INTO "courses" VALUES('Advanced Database Administration','CS003','computer science',3,'cs002','Teng','','west001',60,2,'true','master',1500);
INSERT INTO "courses" VALUES('software project management','CS004','computer science',3,'','Nguyen','','west002',60,1,'true','master',1500);
INSERT INTO "courses" VALUES('Electronic devices and circuits','EE001','electronics',3,'','Jho','','south001',60,0,'true','graduate',1350);
INSERT INTO "courses" VALUES('Signals and systems','EE002','electronics',3,'','Battacharya','','south002',60,0,'true','graduate',1350);
INSERT INTO "courses" VALUES('managerial economics and financial analysis','BM001','business management',3,'','Will','','south003',60,3,'true','graduate',1350);
INSERT INTO "courses" VALUES('web development','CS006','computer',3,'','sudheermende','12:00','south 201',60,0,'true','masters',0);
COMMIT;