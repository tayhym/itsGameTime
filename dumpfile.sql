PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE "django_admin_log" (
    "id" integer NOT NULL PRIMARY KEY,
    "action_time" timestamp NOT NULL,
    "user_id" integer NOT NULL,
    "content_type_id" integer,
    "object_id" text,
    "object_repr" varchar(200) NOT NULL,
    "action_flag" smallint unsigned NOT NULL,
    "change_message" text NOT NULL
);
CREATE TABLE "auth_permission" (
    "id" integer NOT NULL PRIMARY KEY,
    "name" varchar(50) NOT NULL,
    "content_type_id" integer NOT NULL,
    "codename" varchar(100) NOT NULL,
    UNIQUE ("content_type_id", "codename")
);
INSERT INTO "auth_permission" VALUES(1,'Can add log entry',1,'add_logentry');
INSERT INTO "auth_permission" VALUES(2,'Can change log entry',1,'change_logentry');
INSERT INTO "auth_permission" VALUES(3,'Can delete log entry',1,'delete_logentry');
INSERT INTO "auth_permission" VALUES(4,'Can add permission',2,'add_permission');
INSERT INTO "auth_permission" VALUES(5,'Can change permission',2,'change_permission');
INSERT INTO "auth_permission" VALUES(6,'Can delete permission',2,'delete_permission');
INSERT INTO "auth_permission" VALUES(7,'Can add group',3,'add_group');
INSERT INTO "auth_permission" VALUES(8,'Can change group',3,'change_group');
INSERT INTO "auth_permission" VALUES(9,'Can delete group',3,'delete_group');
INSERT INTO "auth_permission" VALUES(10,'Can add user',4,'add_user');
INSERT INTO "auth_permission" VALUES(11,'Can change user',4,'change_user');
INSERT INTO "auth_permission" VALUES(12,'Can delete user',4,'delete_user');
INSERT INTO "auth_permission" VALUES(13,'Can add content type',5,'add_contenttype');
INSERT INTO "auth_permission" VALUES(14,'Can change content type',5,'change_contenttype');
INSERT INTO "auth_permission" VALUES(15,'Can delete content type',5,'delete_contenttype');
INSERT INTO "auth_permission" VALUES(16,'Can add session',6,'add_session');
INSERT INTO "auth_permission" VALUES(17,'Can change session',6,'change_session');
INSERT INTO "auth_permission" VALUES(18,'Can delete session',6,'delete_session');
INSERT INTO "auth_permission" VALUES(19,'Can add venue',7,'add_venue');
INSERT INTO "auth_permission" VALUES(20,'Can change venue',7,'change_venue');
INSERT INTO "auth_permission" VALUES(21,'Can delete venue',7,'delete_venue');
INSERT INTO "auth_permission" VALUES(22,'Can add team',8,'add_team');
INSERT INTO "auth_permission" VALUES(23,'Can change team',8,'change_team');
INSERT INTO "auth_permission" VALUES(24,'Can delete team',8,'delete_team');
INSERT INTO "auth_permission" VALUES(25,'Can add game',9,'add_game');
INSERT INTO "auth_permission" VALUES(26,'Can change game',9,'change_game');
INSERT INTO "auth_permission" VALUES(27,'Can delete game',9,'delete_game');
INSERT INTO "auth_permission" VALUES(28,'Can add player',10,'add_player');
INSERT INTO "auth_permission" VALUES(29,'Can change player',10,'change_player');
INSERT INTO "auth_permission" VALUES(30,'Can delete player',10,'delete_player');
INSERT INTO "auth_permission" VALUES(31,'Can add user info',11,'add_userinfo');
INSERT INTO "auth_permission" VALUES(32,'Can change user info',11,'change_userinfo');
INSERT INTO "auth_permission" VALUES(33,'Can delete user info',11,'delete_userinfo');
INSERT INTO "auth_permission" VALUES(34,'Can add post',12,'add_post');
INSERT INTO "auth_permission" VALUES(35,'Can change post',12,'change_post');
INSERT INTO "auth_permission" VALUES(36,'Can delete post',12,'delete_post');
INSERT INTO "auth_permission" VALUES(37,'Can add question',13,'add_question');
INSERT INTO "auth_permission" VALUES(38,'Can change question',13,'change_question');
INSERT INTO "auth_permission" VALUES(39,'Can delete question',13,'delete_question');
INSERT INTO "auth_permission" VALUES(40,'Can add response',14,'add_response');
INSERT INTO "auth_permission" VALUES(41,'Can change response',14,'change_response');
INSERT INTO "auth_permission" VALUES(42,'Can delete response',14,'delete_response');
INSERT INTO "auth_permission" VALUES(43,'Can add migration history',15,'add_migrationhistory');
INSERT INTO "auth_permission" VALUES(44,'Can change migration history',15,'change_migrationhistory');
INSERT INTO "auth_permission" VALUES(45,'Can delete migration history',15,'delete_migrationhistory');
CREATE TABLE "auth_group_permissions" (
    "id" integer NOT NULL PRIMARY KEY,
    "group_id" integer NOT NULL,
    "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id"),
    UNIQUE ("group_id", "permission_id")
);
CREATE TABLE "auth_group" (
    "id" integer NOT NULL PRIMARY KEY,
    "name" varchar(80) NOT NULL UNIQUE
);
CREATE TABLE "auth_user_groups" (
    "id" integer NOT NULL PRIMARY KEY,
    "user_id" integer NOT NULL,
    "group_id" integer NOT NULL REFERENCES "auth_group" ("id"),
    UNIQUE ("user_id", "group_id")
);
CREATE TABLE "auth_user_user_permissions" (
    "id" integer NOT NULL PRIMARY KEY,
    "user_id" integer NOT NULL,
    "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id"),
    UNIQUE ("user_id", "permission_id")
);
CREATE TABLE "auth_user" (
    "id" integer NOT NULL PRIMARY KEY,
    "password" varchar(128) NOT NULL,
    "last_login" timestamp NOT NULL,
    "is_superuser" bool NOT NULL,
    "username" varchar(30) NOT NULL UNIQUE,
    "first_name" varchar(30) NOT NULL,
    "last_name" varchar(30) NOT NULL,
    "email" varchar(75) NOT NULL,
    "is_staff" bool NOT NULL,
    "is_active" bool NOT NULL,
    "date_joined" timestamp NOT NULL
);
INSERT INTO "auth_user" VALUES(1,'pbkdf2_sha256$12000$hE6ZToZFZsFW$LyQZ2mOwcXGvfKzHMLjcp+z5kK1b5jf+kwo9NfmLxiM=','2014-04-22 21:55:09.467580',1,'xiaohua','','','fish.xyan@gmail.com',1,1,'2014-04-22 21:55:09.467580');
INSERT INTO "auth_user" VALUES(2,'pbkdf2_sha256$12000$3VzZ8bNYAlqU$vlNFFf4+51L5V6CHun2KtWCIca6FvZMVdIqI4Wlywik=','2014-04-23 07:18:38.373613',0,'fish.xyan@gmail.com','Xiaohua','Yan','fish.xyan@gmail.com',0,1,'2014-04-22 21:56:37.244012');
INSERT INTO "auth_user" VALUES(3,'pbkdf2_sha256$12000$jx2kWCdq2SL3$YmtKUdYxCDUhUq6WV72/pnOU4LEEF5mOUSXitIfxiCg=','2014-04-23 04:34:04.745148',0,'xiaohuay@andrew.cmu.edu','Andrew','Yan','xiaohuay@andrew.cmu.edu',0,1,'2014-04-23 02:48:44.961815');
INSERT INTO "auth_user" VALUES(4,'pbkdf2_sha256$12000$dTajrMzm5om5$pOvDWVCkARdkDnJ0qegdfE9GA8p1GNypj66wJD1xhCc=','2014-04-23 04:42:55.623265',0,'xiaohuay@cs.cmu.edu','Xiaohua.CS','Yan','xiaohuay@cs.cmu.edu',0,1,'2014-04-23 04:42:29.453788');
INSERT INTO "auth_user" VALUES(5,'pbkdf2_sha256$12000$8migiNAEATy2$rax6oVI46JDpTcz9gBrxKZQ7rxIgjyTG4neAYUDlYSk=','2014-04-24 22:18:25.838987',0,'tayhym@gmail.com','matthew','t','tayhym@gmail.com',0,1,'2014-04-24 11:46:53.747743');
INSERT INTO "auth_user" VALUES(6,'pbkdf2_sha256$12000$8Dfytoc13TUw$yjfA03OvO2GxhPOzfuieQa09AC1yKos3MMTr18NH1HI=','2014-04-24 11:50:42.433801',0,'mhtay@andrew.cmu.edu','jeff','e','mhtay@andrew.cmu.edu',0,1,'2014-04-24 11:49:24.236468');
CREATE TABLE "django_content_type" (
    "id" integer NOT NULL PRIMARY KEY,
    "name" varchar(100) NOT NULL,
    "app_label" varchar(100) NOT NULL,
    "model" varchar(100) NOT NULL,
    UNIQUE ("app_label", "model")
);
INSERT INTO "django_content_type" VALUES(1,'log entry','admin','logentry');
INSERT INTO "django_content_type" VALUES(2,'permission','auth','permission');
INSERT INTO "django_content_type" VALUES(3,'group','auth','group');
INSERT INTO "django_content_type" VALUES(4,'user','auth','user');
INSERT INTO "django_content_type" VALUES(5,'content type','contenttypes','contenttype');
INSERT INTO "django_content_type" VALUES(6,'session','sessions','session');
INSERT INTO "django_content_type" VALUES(7,'venue','gameTimeApp','venue');
INSERT INTO "django_content_type" VALUES(8,'team','gameTimeApp','team');
INSERT INTO "django_content_type" VALUES(9,'game','gameTimeApp','game');
INSERT INTO "django_content_type" VALUES(10,'player','gameTimeApp','player');
INSERT INTO "django_content_type" VALUES(11,'user info','gameTimeApp','userinfo');
INSERT INTO "django_content_type" VALUES(12,'post','gameTimeApp','post');
INSERT INTO "django_content_type" VALUES(13,'question','gameTimeApp','question');
INSERT INTO "django_content_type" VALUES(14,'response','gameTimeApp','response');
INSERT INTO "django_content_type" VALUES(15,'migration history','south','migrationhistory');
CREATE TABLE "django_session" (
    "session_key" varchar(40) NOT NULL PRIMARY KEY,
    "session_data" text NOT NULL,
    "expire_date" timestamp NOT NULL
);
INSERT INTO "django_session" VALUES('v0d0r2n0dxlmrkq1rudhyu1fntnpmig9','YWMwNjFjYWQwMmQ5N2RhYTY3NmEzZWQ2ZmU1Yzc3MmQxYjIxMWQxMTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=','2014-05-07 07:18:38.376566');
INSERT INTO "django_session" VALUES('q8z8n2tfbjy98tkzfkvhavz5x69a6wau','NDQyZGQzZmYzYTgzMTUxZGFkODU2MGM4MjcwYWFhOWJlNDJmNDg2Yzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6NX0=','2014-05-08 11:48:52.728519');
INSERT INTO "django_session" VALUES('ggn9r8o7h2xjgdtuw4qkwfjqwtzuawdx','NDk3MmZmYTEzNWNhYmY5ZTQ4ZTY4NTBjM2EzZjk1OTAyZWNmYTM4OTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Nn0=','2014-05-08 11:50:42.436262');
INSERT INTO "django_session" VALUES('fzpfuro7kid70r4z8p9t8fe5pje02osu','NDQyZGQzZmYzYTgzMTUxZGFkODU2MGM4MjcwYWFhOWJlNDJmNDg2Yzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6NX0=','2014-05-08 22:13:47.223704');
INSERT INTO "django_session" VALUES('uchd1puf6x8o0lv143c9bt50gzidvb6d','NDQyZGQzZmYzYTgzMTUxZGFkODU2MGM4MjcwYWFhOWJlNDJmNDg2Yzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6NX0=','2014-05-08 22:18:25.841765');
CREATE TABLE "gameTimeApp_venue" (
    "venue_id" varchar(36) NOT NULL PRIMARY KEY,
    "name" varchar(50) NOT NULL,
    "capacity" integer,
    "address" varchar(200) NOT NULL
);
INSERT INTO "gameTimeApp_venue" VALUES('dec253d4-68df-470b-b8fc-d663a7fa4704','Staples Center',18118,'1111 S. Figueroa St., Los Angeles, CA, 90015, USA');
INSERT INTO "gameTimeApp_venue" VALUES('71ca386d-fbaa-479f-b9b6-7858ef2d3cc7','Jobing.com Arena',17125,'9400 W. Maryland Ave., Glendale, AZ, 85305, USA');
INSERT INTO "gameTimeApp_venue" VALUES('1da65282-af4c-4b81-a9de-344b76bb20b0','SAP Center at San Jose',17562,'525 W. Santa Clara St., San Jose, CA, 95113, USA');
INSERT INTO "gameTimeApp_venue" VALUES('152d63d2-825f-4928-a08a-70564268b405','Scotiabank Saddledome',19289,'555 Saddledome Rise S.E., Calgary, AB, T2G 2W1, CANADA');
INSERT INTO "gameTimeApp_venue" VALUES('3b8e1099-8050-42c9-b545-2aa74e93b2e8','Rogers Arena',18890,'800 Griffiths Way, Vancouver, BC, V6B 6G1, CANADA');
INSERT INTO "gameTimeApp_venue" VALUES('0e58dfd1-de2a-4140-843f-ef58a555f43f','Rexall Place',16839,'7424 118th Ave., Edmonton, AB, T5B 4M9, CANADA');
INSERT INTO "gameTimeApp_venue" VALUES('eb3866a7-4163-4517-bd42-d24e8c2522fe','Honda Center',17174,'2695 E. Katella Ave., Anaheim, CA, 92806, USA');
INSERT INTO "gameTimeApp_venue" VALUES('adbd1acb-a053-4944-ba15-383eda91c12e','American Airlines Center',18532,'2500 Victory Ave., Dallas, TX, 75219, USA');
INSERT INTO "gameTimeApp_venue" VALUES('a75eea49-c384-4edb-99f1-d5252773ec83','Pepsi Center',18007,'1000 Chopper Circle, Denver, CO, 80204, USA');
INSERT INTO "gameTimeApp_venue" VALUES('7e6f808b-eff8-42fd-a8e2-d35219f565bd','Xcel Energy Center',18064,'199 W. Kellogg Blvd., St. Paul, MN, 55102, USA');
INSERT INTO "gameTimeApp_venue" VALUES('bbdf58db-fd65-44de-90b9-fcf523c2d764','United Center',19717,'1901 W. Madison St., Chicago, IL, 60612, USA');
INSERT INTO "gameTimeApp_venue" VALUES('cc4e7a62-fae8-4ebb-9a64-f4384385d0b6','Bridgestone Arena',17113,'501 Broadway, Nashville, TN, 37203, USA');
INSERT INTO "gameTimeApp_venue" VALUES('14e923b7-a636-476f-b810-b15967787e3c','Scottrade Center',19150,'1401 Clark Ave., St. Louis, MO, 63103, USA');
INSERT INTO "gameTimeApp_venue" VALUES('900327b2-73d0-4e44-a138-fbf4fcbb058f','MTS Centre',15015,'300 Portage Ave., Winnipeg, MB, R3C 5S5, CANADA');
INSERT INTO "gameTimeApp_venue" VALUES('ab7ddf4d-77aa-44cf-aaf9-9566218af38d','Joe Louis Arena',20066,'600 Civic Center Drive, Detroit, MI, 48226, USA');
INSERT INTO "gameTimeApp_venue" VALUES('854ca968-b25f-44f9-abc5-52bcf8825f15','TD Garden',17565,'100 Legends Way, Boston, MA, 02114, USA');
INSERT INTO "gameTimeApp_venue" VALUES('bd7b42fa-19bb-4b91-8615-214ccc3ff987','First Niagara Center',18690,'One Seymour H. Knox III Plaza, Buffalo, NY, 14203, USA');
INSERT INTO "gameTimeApp_venue" VALUES('e1e675a3-9c13-48b3-9e22-4c063dd9905d','Canadian Tire Centre',19153,'1000 Palladium Drive, Ottawa, ON, K2V 1A5, CANADA');
INSERT INTO "gameTimeApp_venue" VALUES('2ee8c0bf-dfd1-480c-80df-4d5f66a9dc76','Bell Centre',21273,'1909 Avenue des Canadiens-de-Montreal, Montreal, QC, H3B 5E8, USA');
INSERT INTO "gameTimeApp_venue" VALUES('a84c7004-18b2-4c5d-a036-f0c368c08bc5','Air Canada Centre',18819,'40 Bay St., Toronto, ON, M5J 2X2, CANADA');
INSERT INTO "gameTimeApp_venue" VALUES('05aa49b2-f72d-4d42-ab30-f219d32ed97b','Tampa Bay Times Forum',19204,'401 Channelside Drive, Tampa, FL, 33602, USA');
INSERT INTO "gameTimeApp_venue" VALUES('7cc8e88f-9196-4dbc-aa6a-d6f1a0550673','BB&T Center',17040,'One Panther Parkway, Sunrise, FL, 33323, USA');
INSERT INTO "gameTimeApp_venue" VALUES('41a57fc9-a04b-43db-b1f8-87f34f21459b','Nationwide Arena',18144,'200 W. Nationwide Blvd., Columbus, OH, 43215, USA');
INSERT INTO "gameTimeApp_venue" VALUES('c970f791-c3bf-411e-89c6-952695afd414','Prudential Center',17625,'165 Mulberry St., Newark, NJ, 07102, USA');
INSERT INTO "gameTimeApp_venue" VALUES('cd75019b-c46f-4439-9b01-f13ee06f469b','Nassau Veterans Memorial Coliseum',16234,'1255 Hempstead Turnpike, Uniondale, NY, 11553, USA');
INSERT INTO "gameTimeApp_venue" VALUES('bd8053e4-3bdf-4a70-914f-9f6d0051d66d','Madison Square Garden',18200,'Four Pennsylvania Plaza, New York, NY, 10001, USA');
INSERT INTO "gameTimeApp_venue" VALUES('0a162e5b-8d59-42d8-b173-a131bf632ffb','Wells Fargo Center',19537,'3601 S. Broad St., Philadelphia, PA, 19148, USA');
INSERT INTO "gameTimeApp_venue" VALUES('09cab1a6-16ee-4ed9-aefa-c6cc24681b3b','Consol Energy Center',18387,'1001 Fifth Ave., Pittsburgh, PA, 15219, USA');
INSERT INTO "gameTimeApp_venue" VALUES('48f092ed-ce49-4a08-97c6-def284ba6721','Verizon Center',18506,'601 F St. N.W., Washington, DC, 20004, USA');
INSERT INTO "gameTimeApp_venue" VALUES('1ea58cb6-6a28-4619-b010-747ecbc30aa7','PNC Arena',18680,'1400 Edwards Mill Road, Raleigh, NC, 27607, USA');
INSERT INTO "gameTimeApp_venue" VALUES('f62d5b49-d646-56e9-ba60-a875a00830f8','Verizon Center',20290,'601 F St. N.W., Washington, DC, 20004, USA');
INSERT INTO "gameTimeApp_venue" VALUES('a380f011-6e5d-5430-9f37-209e1e8a9b6f','Time Warner Cable Arena',19026,'330 E. Trade St., Charlotte, NC, 28202, USA');
INSERT INTO "gameTimeApp_venue" VALUES('fd21f639-8a47-51ac-a5dd-590629d445cf','Philips Arena',18118,'One Philips Drive, Atlanta, GA, 30303, USA');
INSERT INTO "gameTimeApp_venue" VALUES('b67d5f09-28b2-5bc6-9097-af312007d2f4','American Airlines Arena',19600,'601 Biscayne Blvd., Miami, FL, 33132, USA');
INSERT INTO "gameTimeApp_venue" VALUES('aecd8da6-0404-599c-a792-4b33fb084a2a','Amway Center',18846,'400 W. Church St., Orlando, FL, 32801, USA');
INSERT INTO "gameTimeApp_venue" VALUES('583152aa-de75-5bea-ac92-ac5b8a51f9f9','Madison Square Garden',19812,'Four Pennsylvania Plaza, New York, NY, 10001, USA');
INSERT INTO "gameTimeApp_venue" VALUES('b3dca541-859e-5301-bf90-4ec677a514a9','Wells Fargo Center',20328,'3601 S. Broad St., Philadelphia, PA, 19148, USA');
INSERT INTO "gameTimeApp_venue" VALUES('7a330bcd-ac0f-50ca-bc29-2460e5c476b3','Barclays Center',18200,'620 Atlantic Avenue., Brooklyn, NY, 11217, USA');
INSERT INTO "gameTimeApp_venue" VALUES('7d69b080-91ca-53c9-9302-45c1a72c5549','TD Garden',17565,'100 Legends Way, Boston, MA, 02114, USA');
INSERT INTO "gameTimeApp_venue" VALUES('62cc9661-7b13-56e7-bf4a-bba7ad7be8da','Air Canada Centre',19800,'40 Bay St., Toronto, ON, M5J 2X2, CAN');
INSERT INTO "gameTimeApp_venue" VALUES('38911649-acfd-551a-949b-68f0fcaa44e7','United Center',20917,'1901 W. Madison St., Chicago, IL, 60612, USA');
INSERT INTO "gameTimeApp_venue" VALUES('42cddf7a-0e1f-5f91-ae6f-c620582fdb01','Quicken Loans Arena',20562,'One Center Court, Cleveland, OH, 44115, USA');
INSERT INTO "gameTimeApp_venue" VALUES('24bb478e-eb31-5f8a-8c8d-07f513169ec1','Bankers Life Fieldhouse',18165,'125 S. Pennsylvania St., Indianapolis, IN, 46204, USA');
INSERT INTO "gameTimeApp_venue" VALUES('e83899a5-a6dd-58f8-bd42-34b4857ee714','The Palace of Auburn Hills',22076,'Six Championship Drive, Auburn Hills, MI, 48326, USA');
INSERT INTO "gameTimeApp_venue" VALUES('9bb9599c-17dd-4253-82bb-96fae950a32f','BMO Harris Bradley Center',19000,'1001 N Fourth St, Milwaukee, WI, 53203, USA');
INSERT INTO "gameTimeApp_venue" VALUES('7aed802e-3562-5b73-af1b-3859529f9b95','Target Center',19356,'600 First Ave. North, Minneapolis, MN, 55403, USA');
INSERT INTO "gameTimeApp_venue" VALUES('53bac75a-a667-52b5-a416-b80718ae4ed2','EnergySolutions Arena',19911,'301 W. South Temple St., Salt Lake City, UT, 84101, USA');
INSERT INTO "gameTimeApp_venue" VALUES('a13af216-4409-5021-8dd5-255cc71bffc3','Chesapeake Energy Arena',18203,'100 W. Reno Ave., Oklahoma City, OK, 73102, USA');
INSERT INTO "gameTimeApp_venue" VALUES('1d1f74a2-7b35-56f0-8cbd-552c51cb2c14','Moda Center',19980,'1 Center Court, Portland, OR, 97227, USA');
INSERT INTO "gameTimeApp_venue" VALUES('1a28ef88-76c9-5bcc-b4ee-51d30ca98f4f','Pepsi Center',19155,'1000 Chopper Circle, Denver, CO, 80204, USA');
INSERT INTO "gameTimeApp_venue" VALUES('7657c204-a20b-527a-99cb-dc29218462aa','FedEx Forum',18119,'191 Beale St, Memphis, TN, 38103, USA');
INSERT INTO "gameTimeApp_venue" VALUES('5b239206-57ce-50aa-baaa-627f3349dfdc','Toyota Center',18043,'1510 Polk St., Houston, TX, 77002, USA');
INSERT INTO "gameTimeApp_venue" VALUES('6ec47e31-f778-5319-b6c4-3254e076ba0e','Smoothie King Center',17188,'1501 Girod St., New Orleans, LA, 70113, USA');
INSERT INTO "gameTimeApp_venue" VALUES('8a7580c0-4052-54d5-85cd-85aab6200acf','AT&T Center',18581,'One AT&T Center Parkway, San Antonio, TX, 78219, USA');
INSERT INTO "gameTimeApp_venue" VALUES('401ba62f-19b5-5bfc-84d6-021772943311','American Airlines Center',19200,'2500 Victory Ave., Dallas, TX, 75219, USA');
INSERT INTO "gameTimeApp_venue" VALUES('e25e21f2-1d67-5f13-910b-81fc8629eea7','Oracle Arena',19596,'7000 Coliseum Way, Oakland, CA, 94621, USA');
INSERT INTO "gameTimeApp_venue" VALUES('792ec100-691e-5e16-8ef8-79b2b6ee38ba','Staples Center',18997,'1111 S. Figueroa St., Los Angeles, CA, 90015, USA');
INSERT INTO "gameTimeApp_venue" VALUES('1d2e59b2-2479-5f84-a6a7-e82f65dd8442','US Airways Center',18422,'201 E. Jefferson St., Phoenix, AZ, 85004, USA');
INSERT INTO "gameTimeApp_venue" VALUES('446e0f70-beea-5104-903f-fb65985711a1','Sleep Train Arena',17317,'One Sports Parkway, Sacramento, CA, 95834, USA');
CREATE TABLE "gameTimeApp_team" (
    "team_id" varchar(36) NOT NULL PRIMARY KEY,
    "whole_name" varchar(36) NOT NULL,
    "market" varchar(36),
    "name" varchar(36),
    "league" varchar(20) NOT NULL,
    "venue_id" varchar(36) NOT NULL REFERENCES "gameTimeApp_venue" ("venue_id"),
    "alias" varchar(3)
);
INSERT INTO "gameTimeApp_team" VALUES('44151f7a-0f24-11e2-8525-18a905767e44','Los Angeles Kings','Los Angeles','Kings','nhl','dec253d4-68df-470b-b8fc-d663a7fa4704','LA');
INSERT INTO "gameTimeApp_team" VALUES('44153da1-0f24-11e2-8525-18a905767e44','Phoenix Coyotes','Phoenix','Coyotes','nhl','71ca386d-fbaa-479f-b9b6-7858ef2d3cc7','PHX');
INSERT INTO "gameTimeApp_team" VALUES('44155909-0f24-11e2-8525-18a905767e44','San Jose Sharks','San Jose','Sharks','nhl','1da65282-af4c-4b81-a9de-344b76bb20b0','SJ');
INSERT INTO "gameTimeApp_team" VALUES('44159241-0f24-11e2-8525-18a905767e44','Calgary Flames','Calgary','Flames','nhl','152d63d2-825f-4928-a08a-70564268b405','CGY');
INSERT INTO "gameTimeApp_team" VALUES('4415b0a7-0f24-11e2-8525-18a905767e44','Vancouver Canucks','Vancouver','Canucks','nhl','3b8e1099-8050-42c9-b545-2aa74e93b2e8','VAN');
INSERT INTO "gameTimeApp_team" VALUES('4415ea6c-0f24-11e2-8525-18a905767e44','Edmonton Oilers','Edmonton','Oilers','nhl','0e58dfd1-de2a-4140-843f-ef58a555f43f','EDM');
INSERT INTO "gameTimeApp_team" VALUES('441862de-0f24-11e2-8525-18a905767e44','Anaheim Ducks','Anaheim','Ducks','nhl','eb3866a7-4163-4517-bd42-d24e8c2522fe','ANA');
INSERT INTO "gameTimeApp_team" VALUES('44157522-0f24-11e2-8525-18a905767e44','Dallas Stars','Dallas','Stars','nhl','adbd1acb-a053-4944-ba15-383eda91c12e','DAL');
INSERT INTO "gameTimeApp_team" VALUES('4415ce44-0f24-11e2-8525-18a905767e44','Colorado Avalanche','Colorado','Avalanche','nhl','a75eea49-c384-4edb-99f1-d5252773ec83','COL');
INSERT INTO "gameTimeApp_team" VALUES('4416091c-0f24-11e2-8525-18a905767e44','Minnesota Wild','Minnesota','Wild','nhl','7e6f808b-eff8-42fd-a8e2-d35219f565bd','MIN');
INSERT INTO "gameTimeApp_team" VALUES('4416272f-0f24-11e2-8525-18a905767e44','Chicago Blackhawks','Chicago','Blackhawks','nhl','bbdf58db-fd65-44de-90b9-fcf523c2d764','CHI');
INSERT INTO "gameTimeApp_team" VALUES('441643b7-0f24-11e2-8525-18a905767e44','Nashville Predators','Nashville','Predators','nhl','cc4e7a62-fae8-4ebb-9a64-f4384385d0b6','NSH');
INSERT INTO "gameTimeApp_team" VALUES('441660ea-0f24-11e2-8525-18a905767e44','St. Louis Blues','St. Louis','Blues','nhl','14e923b7-a636-476f-b810-b15967787e3c','STL');
INSERT INTO "gameTimeApp_team" VALUES('44180e55-0f24-11e2-8525-18a905767e44','Winnipeg Jets','Winnipeg','Jets','nhl','900327b2-73d0-4e44-a138-fbf4fcbb058f','WPG');
INSERT INTO "gameTimeApp_team" VALUES('44169bb9-0f24-11e2-8525-18a905767e44','Detroit Red Wings','Detroit','Red Wings','nhl','ab7ddf4d-77aa-44cf-aaf9-9566218af38d','DET');
INSERT INTO "gameTimeApp_team" VALUES('4416ba1a-0f24-11e2-8525-18a905767e44','Boston Bruins','Boston','Bruins','nhl','854ca968-b25f-44f9-abc5-52bcf8825f15','BOS');
INSERT INTO "gameTimeApp_team" VALUES('4416d559-0f24-11e2-8525-18a905767e44','Buffalo Sabres','Buffalo','Sabres','nhl','bd7b42fa-19bb-4b91-8615-214ccc3ff987','BUF');
INSERT INTO "gameTimeApp_team" VALUES('4416f5e2-0f24-11e2-8525-18a905767e44','Ottawa Senators','Ottawa','Senators','nhl','e1e675a3-9c13-48b3-9e22-4c063dd9905d','OTT');
INSERT INTO "gameTimeApp_team" VALUES('441713b7-0f24-11e2-8525-18a905767e44','Montreal Canadiens','Montreal','Canadiens','nhl','2ee8c0bf-dfd1-480c-80df-4d5f66a9dc76','MTL');
INSERT INTO "gameTimeApp_team" VALUES('441730a9-0f24-11e2-8525-18a905767e44','Toronto Maple Leafs','Toronto','Maple Leafs','nhl','a84c7004-18b2-4c5d-a036-f0c368c08bc5','TOR');
INSERT INTO "gameTimeApp_team" VALUES('4417d3cb-0f24-11e2-8525-18a905767e44','Tampa Bay Lightning','Tampa Bay','Lightning','nhl','05aa49b2-f72d-4d42-ab30-f219d32ed97b','TB');
INSERT INTO "gameTimeApp_team" VALUES('4418464d-0f24-11e2-8525-18a905767e44','Florida Panthers','Florida','Panthers','nhl','7cc8e88f-9196-4dbc-aa6a-d6f1a0550673','FLA');
INSERT INTO "gameTimeApp_team" VALUES('44167db4-0f24-11e2-8525-18a905767e44','Columbus Blue Jackets','Columbus','Blue Jackets','nhl','41a57fc9-a04b-43db-b1f8-87f34f21459b','CBJ');
INSERT INTO "gameTimeApp_team" VALUES('44174b0c-0f24-11e2-8525-18a905767e44','New Jersey Devils','New Jersey','Devils','nhl','c970f791-c3bf-411e-89c6-952695afd414','NJ');
INSERT INTO "gameTimeApp_team" VALUES('441766b9-0f24-11e2-8525-18a905767e44','New York Islanders','New York','Islanders','nhl','cd75019b-c46f-4439-9b01-f13ee06f469b','NYI');
INSERT INTO "gameTimeApp_team" VALUES('441781b9-0f24-11e2-8525-18a905767e44','New York Rangers','New York','Rangers','nhl','bd8053e4-3bdf-4a70-914f-9f6d0051d66d','NYR');
INSERT INTO "gameTimeApp_team" VALUES('44179d47-0f24-11e2-8525-18a905767e44','Philadelphia Flyers','Philadelphia','Flyers','nhl','0a162e5b-8d59-42d8-b173-a131bf632ffb','PHI');
INSERT INTO "gameTimeApp_team" VALUES('4417b7d7-0f24-11e2-8525-18a905767e44','Pittsburgh Penguins','Pittsburgh','Penguins','nhl','09cab1a6-16ee-4ed9-aefa-c6cc24681b3b','PIT');
INSERT INTO "gameTimeApp_team" VALUES('4417eede-0f24-11e2-8525-18a905767e44','Washington Capitals','Washington','Capitals','nhl','48f092ed-ce49-4a08-97c6-def284ba6721','WSH');
INSERT INTO "gameTimeApp_team" VALUES('44182a9d-0f24-11e2-8525-18a905767e44','Carolina Hurricanes','Carolina','Hurricanes','nhl','1ea58cb6-6a28-4619-b010-747ecbc30aa7','CAR');
INSERT INTO "gameTimeApp_team" VALUES('583ec8d4-fb46-11e1-82cb-f4ce4684ea4c','Washington Wizards','Washington','Wizards','nba','f62d5b49-d646-56e9-ba60-a875a00830f8','WAS');
INSERT INTO "gameTimeApp_team" VALUES('583ec97e-fb46-11e1-82cb-f4ce4684ea4c','Charlotte Bobcats','Charlotte','Bobcats','nba','a380f011-6e5d-5430-9f37-209e1e8a9b6f','CHA');
INSERT INTO "gameTimeApp_team" VALUES('583ecb8f-fb46-11e1-82cb-f4ce4684ea4c','Atlanta Hawks','Atlanta','Hawks','nba','fd21f639-8a47-51ac-a5dd-590629d445cf','ATL');
INSERT INTO "gameTimeApp_team" VALUES('583ecea6-fb46-11e1-82cb-f4ce4684ea4c','Miami Heat','Miami','Heat','nba','b67d5f09-28b2-5bc6-9097-af312007d2f4','MIA');
INSERT INTO "gameTimeApp_team" VALUES('583ed157-fb46-11e1-82cb-f4ce4684ea4c','Orlando Magic','Orlando','Magic','nba','aecd8da6-0404-599c-a792-4b33fb084a2a','ORL');
INSERT INTO "gameTimeApp_team" VALUES('583ec70e-fb46-11e1-82cb-f4ce4684ea4c','New York Knicks','New York','Knicks','nba','583152aa-de75-5bea-ac92-ac5b8a51f9f9','NYK');
INSERT INTO "gameTimeApp_team" VALUES('583ec87d-fb46-11e1-82cb-f4ce4684ea4c','Philadelphia 76ers','Philadelphia','76ers','nba','b3dca541-859e-5301-bf90-4ec677a514a9','PHI');
INSERT INTO "gameTimeApp_team" VALUES('583ec9d6-fb46-11e1-82cb-f4ce4684ea4c','Brooklyn Nets','Brooklyn','Nets','nba','7a330bcd-ac0f-50ca-bc29-2460e5c476b3','BKN');
INSERT INTO "gameTimeApp_team" VALUES('583eccfa-fb46-11e1-82cb-f4ce4684ea4c','Boston Celtics','Boston','Celtics','nba','7d69b080-91ca-53c9-9302-45c1a72c5549','BOS');
INSERT INTO "gameTimeApp_team" VALUES('583ecda6-fb46-11e1-82cb-f4ce4684ea4c','Toronto Raptors','Toronto','Raptors','nba','62cc9661-7b13-56e7-bf4a-bba7ad7be8da','TOR');
INSERT INTO "gameTimeApp_team" VALUES('583ec5fd-fb46-11e1-82cb-f4ce4684ea4c','Chicago Bulls','Chicago','Bulls','nba','38911649-acfd-551a-949b-68f0fcaa44e7','CHI');
INSERT INTO "gameTimeApp_team" VALUES('583ec773-fb46-11e1-82cb-f4ce4684ea4c','Cleveland Cavaliers','Cleveland','Cavaliers','nba','42cddf7a-0e1f-5f91-ae6f-c620582fdb01','CLE');
INSERT INTO "gameTimeApp_team" VALUES('583ec7cd-fb46-11e1-82cb-f4ce4684ea4c','Indiana Pacers','Indiana','Pacers','nba','24bb478e-eb31-5f8a-8c8d-07f513169ec1','IND');
INSERT INTO "gameTimeApp_team" VALUES('583ec928-fb46-11e1-82cb-f4ce4684ea4c','Detroit Pistons','Detroit','Pistons','nba','e83899a5-a6dd-58f8-bd42-34b4857ee714','DET');
INSERT INTO "gameTimeApp_team" VALUES('583ecefd-fb46-11e1-82cb-f4ce4684ea4c','Milwaukee Bucks','Milwaukee','Bucks','nba','9bb9599c-17dd-4253-82bb-96fae950a32f','MIL');
INSERT INTO "gameTimeApp_team" VALUES('583eca2f-fb46-11e1-82cb-f4ce4684ea4c','Minnesota Timberwolves','Minnesota','Timberwolves','nba','7aed802e-3562-5b73-af1b-3859529f9b95','MIN');
INSERT INTO "gameTimeApp_team" VALUES('583ece50-fb46-11e1-82cb-f4ce4684ea4c','Utah Jazz','Utah','Jazz','nba','53bac75a-a667-52b5-a416-b80718ae4ed2','UTA');
INSERT INTO "gameTimeApp_team" VALUES('583ecfff-fb46-11e1-82cb-f4ce4684ea4c','Oklahoma City Thunder','Oklahoma City','Thunder','nba','a13af216-4409-5021-8dd5-255cc71bffc3','OKC');
INSERT INTO "gameTimeApp_team" VALUES('583ed056-fb46-11e1-82cb-f4ce4684ea4c','Portland Trail Blazers','Portland','Trail Blazers','nba','1d1f74a2-7b35-56f0-8cbd-552c51cb2c14','POR');
INSERT INTO "gameTimeApp_team" VALUES('583ed102-fb46-11e1-82cb-f4ce4684ea4c','Denver Nuggets','Denver','Nuggets','nba','1a28ef88-76c9-5bcc-b4ee-51d30ca98f4f','DEN');
INSERT INTO "gameTimeApp_team" VALUES('583eca88-fb46-11e1-82cb-f4ce4684ea4c','Memphis Grizzlies','Memphis','Grizzlies','nba','7657c204-a20b-527a-99cb-dc29218462aa','MEM');
INSERT INTO "gameTimeApp_team" VALUES('583ecb3a-fb46-11e1-82cb-f4ce4684ea4c','Houston Rockets','Houston','Rockets','nba','5b239206-57ce-50aa-baaa-627f3349dfdc','HOU');
INSERT INTO "gameTimeApp_team" VALUES('583ecc9a-fb46-11e1-82cb-f4ce4684ea4c','New Orleans Pelicans','New Orleans','Pelicans','nba','6ec47e31-f778-5319-b6c4-3254e076ba0e','NOP');
INSERT INTO "gameTimeApp_team" VALUES('583ecd4f-fb46-11e1-82cb-f4ce4684ea4c','San Antonio Spurs','San Antonio','Spurs','nba','8a7580c0-4052-54d5-85cd-85aab6200acf','SAS');
INSERT INTO "gameTimeApp_team" VALUES('583ecf50-fb46-11e1-82cb-f4ce4684ea4c','Dallas Mavericks','Dallas','Mavericks','nba','401ba62f-19b5-5bfc-84d6-021772943311','DAL');
INSERT INTO "gameTimeApp_team" VALUES('583ec825-fb46-11e1-82cb-f4ce4684ea4c','Golden State Warriors','Golden State','Warriors','nba','e25e21f2-1d67-5f13-910b-81fc8629eea7','GSW');
INSERT INTO "gameTimeApp_team" VALUES('583ecae2-fb46-11e1-82cb-f4ce4684ea4c','Los Angeles Lakers','Los Angeles','Lakers','nba','792ec100-691e-5e16-8ef8-79b2b6ee38ba','LAL');
INSERT INTO "gameTimeApp_team" VALUES('583ecdfb-fb46-11e1-82cb-f4ce4684ea4c','Los Angeles Clippers','Los Angeles','Clippers','nba','792ec100-691e-5e16-8ef8-79b2b6ee38ba','LAC');
INSERT INTO "gameTimeApp_team" VALUES('583ecfa8-fb46-11e1-82cb-f4ce4684ea4c','Phoenix Suns','Phoenix','Suns','nba','1d2e59b2-2479-5f84-a6a7-e82f65dd8442','PHX');
INSERT INTO "gameTimeApp_team" VALUES('583ed0ac-fb46-11e1-82cb-f4ce4684ea4c','Sacramento Kings','Sacramento','Kings','nba','446e0f70-beea-5104-903f-fb65985711a1','SAC');
CREATE TABLE "gameTimeApp_game" (
    "game_id" varchar(36) NOT NULL PRIMARY KEY,
    "venue_id" varchar(36) NOT NULL REFERENCES "gameTimeApp_venue" ("venue_id"),
    "league" varchar(20) NOT NULL,
    "start_time" timestamp NOT NULL,
    "home_team_id" varchar(36) NOT NULL REFERENCES "gameTimeApp_team" ("team_id"),
    "away_team_id" varchar(36) NOT NULL REFERENCES "gameTimeApp_team" ("team_id")
);
INSERT INTO "gameTimeApp_game" VALUES('3c6b8300-34a5-4e0b-b1e7-aa2d2662fc4d','05aa49b2-f72d-4d42-ab30-f219d32ed97b','nhl','2014-04-16 23:00:00','4417d3cb-0f24-11e2-8525-18a905767e44','441713b7-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('8c4554a3-6b95-409b-b51d-b3a77c0d4266','09cab1a6-16ee-4ed9-aefa-c6cc24681b3b','nhl','2014-04-16 23:30:00','4417b7d7-0f24-11e2-8525-18a905767e44','44167db4-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('73f81c73-be00-460b-a690-bc0eb2913c0a','eb3866a7-4163-4517-bd42-d24e8c2522fe','nhl','2014-04-17 02:00:00','441862de-0f24-11e2-8525-18a905767e44','44157522-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('d6e6186a-65c6-4d38-a8a9-455c9b375683','bd8053e4-3bdf-4a70-914f-9f6d0051d66d','nhl','2014-04-17 23:00:00','441781b9-0f24-11e2-8525-18a905767e44','44179d47-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('1fb4a1d3-7d45-4b4f-b5b2-812d2a4d7df8','14e923b7-a636-476f-b810-b15967787e3c','nhl','2014-04-18 00:00:00','441660ea-0f24-11e2-8525-18a905767e44','4416272f-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('3a958730-04de-4ed0-8e6d-e41d7b929343','a75eea49-c384-4edb-99f1-d5252773ec83','nhl','2014-04-18 01:30:00','4415ce44-0f24-11e2-8525-18a905767e44','4416091c-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('9733155c-2be5-4480-aa2c-0b2fc4d5ff43','1da65282-af4c-4b81-a9de-344b76bb20b0','nhl','2014-04-18 02:30:00','44155909-0f24-11e2-8525-18a905767e44','44151f7a-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('2cc7825d-2311-479f-9e83-2fde677adddf','05aa49b2-f72d-4d42-ab30-f219d32ed97b','nhl','2014-04-18 23:00:00','4417d3cb-0f24-11e2-8525-18a905767e44','441713b7-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('e957f08f-cb6e-4021-b6d8-48421e85d37b','854ca968-b25f-44f9-abc5-52bcf8825f15','nhl','2014-04-18 23:30:00','4416ba1a-0f24-11e2-8525-18a905767e44','44169bb9-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('9b56a88d-a923-42dc-ab9c-f3b9f32f28a0','eb3866a7-4163-4517-bd42-d24e8c2522fe','nhl','2014-04-19 02:00:00','441862de-0f24-11e2-8525-18a905767e44','44157522-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('0b9349e7-885c-4688-85e4-b210da9df1d8','14e923b7-a636-476f-b810-b15967787e3c','nhl','2014-04-19 19:00:00','441660ea-0f24-11e2-8525-18a905767e44','4416272f-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('6b0c10a6-14c5-4804-9f8c-f932c30e372b','09cab1a6-16ee-4ed9-aefa-c6cc24681b3b','nhl','2014-04-19 23:00:00','4417b7d7-0f24-11e2-8525-18a905767e44','44167db4-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('e0072374-a4ba-4744-8268-e9fac03ebec2','a75eea49-c384-4edb-99f1-d5252773ec83','nhl','2014-04-20 01:30:00','4415ce44-0f24-11e2-8525-18a905767e44','4416091c-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('7cf49705-0c38-4135-8c3b-2e29b02b5c7d','bd8053e4-3bdf-4a70-914f-9f6d0051d66d','nhl','2014-04-20 16:00:00','441781b9-0f24-11e2-8525-18a905767e44','44179d47-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('76196fbc-304a-4a01-a992-fe693e27d61c','854ca968-b25f-44f9-abc5-52bcf8825f15','nhl','2014-04-20 19:00:00','4416ba1a-0f24-11e2-8525-18a905767e44','44169bb9-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('2c0144d0-3737-41eb-b12f-f609e32e0ea4','2ee8c0bf-dfd1-480c-80df-4d5f66a9dc76','nhl','2014-04-20 23:00:00','441713b7-0f24-11e2-8525-18a905767e44','4417d3cb-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('8bea220e-b668-43a5-a64c-85a3e66e48d2','1da65282-af4c-4b81-a9de-344b76bb20b0','nhl','2014-04-21 02:00:00','44155909-0f24-11e2-8525-18a905767e44','44151f7a-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('28ce49c1-cb2a-469b-aad1-2343d6ec39ab','41a57fc9-a04b-43db-b1f8-87f34f21459b','nhl','2014-04-21 23:00:00','44167db4-0f24-11e2-8525-18a905767e44','4417b7d7-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('64b152f8-0c76-4695-9e1a-2d1eb59e0ac1','7e6f808b-eff8-42fd-a8e2-d35219f565bd','nhl','2014-04-21 23:00:00','4416091c-0f24-11e2-8525-18a905767e44','4415ce44-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('dd497058-7464-4a55-9c48-e8f68c1f795d','bbdf58db-fd65-44de-90b9-fcf523c2d764','nhl','2014-04-22 00:30:00','4416272f-0f24-11e2-8525-18a905767e44','441660ea-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('d5c41320-56fd-41a6-ae7b-a2fe9d1ce9b4','adbd1acb-a053-4944-ba15-383eda91c12e','nhl','2014-04-22 01:30:00','44157522-0f24-11e2-8525-18a905767e44','441862de-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('067a6e24-4594-47cc-afc0-2931a8c712bf','2ee8c0bf-dfd1-480c-80df-4d5f66a9dc76','nhl','2014-04-22 23:00:00','441713b7-0f24-11e2-8525-18a905767e44','4417d3cb-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('461f91b2-7ae2-44bb-99a6-11e17ee82c59','ab7ddf4d-77aa-44cf-aaf9-9566218af38d','nhl','2014-04-22 23:30:00','44169bb9-0f24-11e2-8525-18a905767e44','4416ba1a-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('0e16f3ec-2403-4cb6-bff9-f9f398bf4bed','0a162e5b-8d59-42d8-b173-a131bf632ffb','nhl','2014-04-23 00:00:00','44179d47-0f24-11e2-8525-18a905767e44','441781b9-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('13b7ede8-73a4-469d-ab6d-4187ff10d3a2','dec253d4-68df-470b-b8fc-d663a7fa4704','nhl','2014-04-23 02:00:00','44151f7a-0f24-11e2-8525-18a905767e44','44155909-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('f22287fb-6ca6-438f-921c-9b4ced950dd1','41a57fc9-a04b-43db-b1f8-87f34f21459b','nhl','2014-04-23 23:00:00','44167db4-0f24-11e2-8525-18a905767e44','4417b7d7-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('474d9c6c-9143-4b2d-9c23-12f1dc1a3299','adbd1acb-a053-4944-ba15-383eda91c12e','nhl','2014-04-24 00:00:00','44157522-0f24-11e2-8525-18a905767e44','441862de-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('a215ed2e-2786-40ec-a403-1fe8f61ad56b','bbdf58db-fd65-44de-90b9-fcf523c2d764','nhl','2014-04-24 01:30:00','4416272f-0f24-11e2-8525-18a905767e44','441660ea-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('0de027fe-9c19-4558-842e-0acf4574b0fa','05aa49b2-f72d-4d42-ab30-f219d32ed97b','nhl','2014-04-24 23:00:00','4417d3cb-0f24-11e2-8525-18a905767e44','441713b7-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('bd3b1b3e-ce9a-4336-bfb5-b76cc2e9519c','ab7ddf4d-77aa-44cf-aaf9-9566218af38d','nhl','2014-04-25 00:00:00','44169bb9-0f24-11e2-8525-18a905767e44','4416ba1a-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('5f48f350-45a1-4f0d-9fa8-34a5fafbff69','7e6f808b-eff8-42fd-a8e2-d35219f565bd','nhl','2014-04-25 01:30:00','4416091c-0f24-11e2-8525-18a905767e44','4415ce44-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('043e7d08-526b-4c4e-8d7c-bac98e29f6fe','dec253d4-68df-470b-b8fc-d663a7fa4704','nhl','2014-04-25 02:30:00','44151f7a-0f24-11e2-8525-18a905767e44','44155909-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('778501b3-158e-46f7-8357-37ae956b5297','0a162e5b-8d59-42d8-b173-a131bf632ffb','nhl','2014-04-25 23:00:00','44179d47-0f24-11e2-8525-18a905767e44','441781b9-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('d206991b-f2dc-4ec0-8fc3-ce590d937dfd','14e923b7-a636-476f-b810-b15967787e3c','nhl','2014-04-26 00:00:00','441660ea-0f24-11e2-8525-18a905767e44','4416272f-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('391285f5-c910-4460-9e3a-2905fc029e70','eb3866a7-4163-4517-bd42-d24e8c2522fe','nhl','2014-04-26 02:30:00','441862de-0f24-11e2-8525-18a905767e44','44157522-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('1e369c68-e0b8-4a0d-b737-75e6b6850865','09cab1a6-16ee-4ed9-aefa-c6cc24681b3b','nhl','2014-04-26 05:00:00','4417b7d7-0f24-11e2-8525-18a905767e44','44167db4-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('7e8f62b5-e39a-4d26-90da-dbab40abe18d','a75eea49-c384-4edb-99f1-d5252773ec83','nhl','2014-04-26 05:00:00','4415ce44-0f24-11e2-8525-18a905767e44','4416091c-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('8ff27045-74a5-46d7-a50d-9332ddcc3dd0','1da65282-af4c-4b81-a9de-344b76bb20b0','nhl','2014-04-26 05:00:00','44155909-0f24-11e2-8525-18a905767e44','44151f7a-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('8dd5c2e8-eb50-4983-881e-b3e2f469ba40','854ca968-b25f-44f9-abc5-52bcf8825f15','nhl','2014-04-26 19:00:00','4416ba1a-0f24-11e2-8525-18a905767e44','44169bb9-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('c6109f8a-9e6a-4e2f-901c-7439af0f3c1d','2ee8c0bf-dfd1-480c-80df-4d5f66a9dc76','nhl','2014-04-27 05:00:00','441713b7-0f24-11e2-8525-18a905767e44','4417d3cb-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('ea68dd18-8b33-44af-a572-0a4e20f91a56','adbd1acb-a053-4944-ba15-383eda91c12e','nhl','2014-04-27 05:00:00','44157522-0f24-11e2-8525-18a905767e44','441862de-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('ec167534-ec4f-4f6f-827f-6c4e6f85593e','bd8053e4-3bdf-4a70-914f-9f6d0051d66d','nhl','2014-04-27 16:00:00','441781b9-0f24-11e2-8525-18a905767e44','44179d47-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('364adfaf-e632-4180-aa3a-a8111812f3f7','bbdf58db-fd65-44de-90b9-fcf523c2d764','nhl','2014-04-27 19:00:00','4416272f-0f24-11e2-8525-18a905767e44','441660ea-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('40b8c07a-b3a6-4801-a340-2bee2464a79d','7e6f808b-eff8-42fd-a8e2-d35219f565bd','nhl','2014-04-28 05:00:00','4416091c-0f24-11e2-8525-18a905767e44','4415ce44-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('41ba9f9c-965a-4537-b24f-2509329ee456','dec253d4-68df-470b-b8fc-d663a7fa4704','nhl','2014-04-28 05:00:00','44151f7a-0f24-11e2-8525-18a905767e44','44155909-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('78b61904-2734-4d99-853d-30d955557740','41a57fc9-a04b-43db-b1f8-87f34f21459b','nhl','2014-04-28 05:00:00','44167db4-0f24-11e2-8525-18a905767e44','4417b7d7-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('f3245f04-3969-4edc-89bc-5a521c8f9907','ab7ddf4d-77aa-44cf-aaf9-9566218af38d','nhl','2014-04-28 05:00:00','44169bb9-0f24-11e2-8525-18a905767e44','4416ba1a-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('602ef5c0-b8a9-4700-8e4f-6d28e850329e','eb3866a7-4163-4517-bd42-d24e8c2522fe','nhl','2014-04-29 05:00:00','441862de-0f24-11e2-8525-18a905767e44','44157522-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('6547ee14-e4a5-4dcf-b1d3-3f04cd837f02','0a162e5b-8d59-42d8-b173-a131bf632ffb','nhl','2014-04-29 05:00:00','44179d47-0f24-11e2-8525-18a905767e44','441781b9-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('919e7c08-3e7f-4699-bca5-444e3f58c30a','14e923b7-a636-476f-b810-b15967787e3c','nhl','2014-04-29 05:00:00','441660ea-0f24-11e2-8525-18a905767e44','4416272f-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('b6a67c10-6dab-461a-8c34-44519886c38b','05aa49b2-f72d-4d42-ab30-f219d32ed97b','nhl','2014-04-29 05:00:00','4417d3cb-0f24-11e2-8525-18a905767e44','441713b7-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('05afa2ea-12f5-4e76-96cc-0e614d0449ea','bd8053e4-3bdf-4a70-914f-9f6d0051d66d','nhl','2014-04-30 05:00:00','441781b9-0f24-11e2-8525-18a905767e44','44179d47-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('11b51d74-fc5a-4cd5-9b94-7e5ec9bbb7b3','854ca968-b25f-44f9-abc5-52bcf8825f15','nhl','2014-04-30 05:00:00','4416ba1a-0f24-11e2-8525-18a905767e44','44169bb9-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('15a5d518-8da7-4384-93ea-6fe90e95f477','a75eea49-c384-4edb-99f1-d5252773ec83','nhl','2014-04-30 05:00:00','4415ce44-0f24-11e2-8525-18a905767e44','4416091c-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('265f9818-acc5-4a52-a882-f77f21a76d97','1da65282-af4c-4b81-a9de-344b76bb20b0','nhl','2014-04-30 05:00:00','44155909-0f24-11e2-8525-18a905767e44','44151f7a-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('51b89d4f-9ba2-490f-8a5b-e22fe1f9fd01','09cab1a6-16ee-4ed9-aefa-c6cc24681b3b','nhl','2014-04-30 05:00:00','4417b7d7-0f24-11e2-8525-18a905767e44','44167db4-0f24-11e2-8525-18a905767e44');
INSERT INTO "gameTimeApp_game" VALUES('b9ca64b8-f1a6-407a-a624-327d7c0e677b','62cc9661-7b13-56e7-bf4a-bba7ad7be8da','nba','2014-04-19 16:30:00','583ecda6-fb46-11e1-82cb-f4ce4684ea4c','583ec9d6-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('582c27bb-9946-4b9b-9047-eb75658a5093','792ec100-691e-5e16-8ef8-79b2b6ee38ba','nba','2014-04-19 19:30:00','583ecdfb-fb46-11e1-82cb-f4ce4684ea4c','583ec825-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('63bb1eb9-0824-447a-ae04-ad4a2e91c149','24bb478e-eb31-5f8a-8c8d-07f513169ec1','nba','2014-04-19 23:00:00','583ec7cd-fb46-11e1-82cb-f4ce4684ea4c','583ecb8f-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('d9946a04-bc50-43cb-8d11-3770132a4c21','a13af216-4409-5021-8dd5-255cc71bffc3','nba','2014-04-20 01:30:00','583ecfff-fb46-11e1-82cb-f4ce4684ea4c','583eca88-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('51a25f7d-8ce7-4980-bee0-b2d9dd623c37','8a7580c0-4052-54d5-85cd-85aab6200acf','nba','2014-04-20 17:00:00','583ecd4f-fb46-11e1-82cb-f4ce4684ea4c','583ecf50-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('f660857a-f6de-4622-a7d5-f1200ff759dc','b67d5f09-28b2-5bc6-9097-af312007d2f4','nba','2014-04-20 19:30:00','583ecea6-fb46-11e1-82cb-f4ce4684ea4c','583ec97e-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('8c41cd17-b40a-4cf4-bc2a-8863078fb98e','38911649-acfd-551a-949b-68f0fcaa44e7','nba','2014-04-20 23:00:00','583ec5fd-fb46-11e1-82cb-f4ce4684ea4c','583ec8d4-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('21ad4a9d-0008-4b12-8eb4-34abf207d8b8','5b239206-57ce-50aa-baaa-627f3349dfdc','nba','2014-04-21 01:30:00','583ecb3a-fb46-11e1-82cb-f4ce4684ea4c','583ed056-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('8cf04bb1-6771-4c9c-8550-2774818c627f','a13af216-4409-5021-8dd5-255cc71bffc3','nba','2014-04-22 00:00:00','583ecfff-fb46-11e1-82cb-f4ce4684ea4c','583eca88-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('a8e1f2a6-2843-4e66-a308-b2126592f9c3','792ec100-691e-5e16-8ef8-79b2b6ee38ba','nba','2014-04-22 02:30:00','583ecdfb-fb46-11e1-82cb-f4ce4684ea4c','583ec825-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('e617e58a-622a-49a6-b739-47410a3bd012','24bb478e-eb31-5f8a-8c8d-07f513169ec1','nba','2014-04-22 23:00:00','583ec7cd-fb46-11e1-82cb-f4ce4684ea4c','583ecb8f-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('95ae7162-0673-4465-9610-f5cb7ecc1ae0','62cc9661-7b13-56e7-bf4a-bba7ad7be8da','nba','2014-04-22 23:30:00','583ecda6-fb46-11e1-82cb-f4ce4684ea4c','583ec9d6-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('4edc6586-d1ef-447d-9189-32b7eded3a99','38911649-acfd-551a-949b-68f0fcaa44e7','nba','2014-04-23 01:30:00','583ec5fd-fb46-11e1-82cb-f4ce4684ea4c','583ec8d4-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('ac686774-a146-40d4-8258-bea09f1465a6','b67d5f09-28b2-5bc6-9097-af312007d2f4','nba','2014-04-23 23:00:00','583ecea6-fb46-11e1-82cb-f4ce4684ea4c','583ec97e-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('c0228af1-f787-4e3f-a3bb-e245ad56137c','8a7580c0-4052-54d5-85cd-85aab6200acf','nba','2014-04-24 00:00:00','583ecd4f-fb46-11e1-82cb-f4ce4684ea4c','583ecf50-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('5c5cbef6-a7b8-4bfc-a271-6a72e6ff9a51','5b239206-57ce-50aa-baaa-627f3349dfdc','nba','2014-04-24 01:30:00','583ecb3a-fb46-11e1-82cb-f4ce4684ea4c','583ed056-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('5b40aec4-49f7-4674-b6a3-9dbdd26db974','fd21f639-8a47-51ac-a5dd-590629d445cf','nba','2014-04-24 23:00:00','583ecb8f-fb46-11e1-82cb-f4ce4684ea4c','583ec7cd-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('46e349a5-13ce-405e-854e-097ed9680396','7657c204-a20b-527a-99cb-dc29218462aa','nba','2014-04-25 00:00:00','583eca88-fb46-11e1-82cb-f4ce4684ea4c','583ecfff-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('e952b101-3eff-466c-a29b-fa78331180aa','e25e21f2-1d67-5f13-910b-81fc8629eea7','nba','2014-04-25 02:30:00','583ec825-fb46-11e1-82cb-f4ce4684ea4c','583ecdfb-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('8224fe25-95ed-4dda-b1d2-6e9505ee13ab','7a330bcd-ac0f-50ca-bc29-2460e5c476b3','nba','2014-04-25 23:00:00','583ec9d6-fb46-11e1-82cb-f4ce4684ea4c','583ecda6-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('6c6e566d-0bf2-4c50-a320-f1355f3db9b0','f62d5b49-d646-56e9-ba60-a875a00830f8','nba','2014-04-26 00:00:00','583ec8d4-fb46-11e1-82cb-f4ce4684ea4c','583ec5fd-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('5f8d810e-8228-455e-ba28-d9300a946858','1d1f74a2-7b35-56f0-8cbd-552c51cb2c14','nba','2014-04-26 02:30:00','583ed056-fb46-11e1-82cb-f4ce4684ea4c','583ecb3a-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('0cee7a0d-c320-4c4d-9fc3-fa273c2992f4','fd21f639-8a47-51ac-a5dd-590629d445cf','nba','2014-04-26 18:00:00','583ecb8f-fb46-11e1-82cb-f4ce4684ea4c','583ec7cd-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('2eab6356-9c03-49dd-bd39-a9e1afa111d2','401ba62f-19b5-5bfc-84d6-021772943311','nba','2014-04-26 20:30:00','583ecf50-fb46-11e1-82cb-f4ce4684ea4c','583ecd4f-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('7ec8acd4-0bc9-404b-ae33-1a3e8a4b285a','a380f011-6e5d-5430-9f37-209e1e8a9b6f','nba','2014-04-26 23:00:00','583ec97e-fb46-11e1-82cb-f4ce4684ea4c','583ecea6-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('e30c708e-4145-4bd0-8aa6-55e6e2c4a150','7657c204-a20b-527a-99cb-dc29218462aa','nba','2014-04-27 01:30:00','583eca88-fb46-11e1-82cb-f4ce4684ea4c','583ecfff-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('b1661361-8bc2-42a4-a5bf-6f4d3dd7dc81','f62d5b49-d646-56e9-ba60-a875a00830f8','nba','2014-04-27 17:00:00','583ec8d4-fb46-11e1-82cb-f4ce4684ea4c','583ec5fd-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('b8b9e9c6-db17-4d2b-9ef8-d131ddc6cfd5','e25e21f2-1d67-5f13-910b-81fc8629eea7','nba','2014-04-27 19:30:00','583ec825-fb46-11e1-82cb-f4ce4684ea4c','583ecdfb-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('a7584d10-59d1-4efb-8394-757a6368e29f','7a330bcd-ac0f-50ca-bc29-2460e5c476b3','nba','2014-04-27 23:00:00','583ec9d6-fb46-11e1-82cb-f4ce4684ea4c','583ecda6-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('772e5f46-6519-407b-9e72-7075afb0f229','1d1f74a2-7b35-56f0-8cbd-552c51cb2c14','nba','2014-04-28 01:30:00','583ed056-fb46-11e1-82cb-f4ce4684ea4c','583ecb3a-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('fdeb6991-e543-4660-8b86-fd779a02af78','a380f011-6e5d-5430-9f37-209e1e8a9b6f','nba','2014-04-28 23:00:00','583ec97e-fb46-11e1-82cb-f4ce4684ea4c','583ecea6-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('b7e8e6d1-e3a5-4f77-beb2-12b297aa01ca','24bb478e-eb31-5f8a-8c8d-07f513169ec1','nba','2014-04-29 00:00:00','583ec7cd-fb46-11e1-82cb-f4ce4684ea4c','583ecb8f-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('12905f3e-226b-4cf4-b926-e29b05052f93','401ba62f-19b5-5bfc-84d6-021772943311','nba','2014-04-29 01:30:00','583ecf50-fb46-11e1-82cb-f4ce4684ea4c','583ecd4f-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('796fbb66-fe02-4328-a50b-3c2bbdadc828','38911649-acfd-551a-949b-68f0fcaa44e7','nba','2014-04-29 05:00:00','583ec5fd-fb46-11e1-82cb-f4ce4684ea4c','583ec8d4-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('f18653ce-9cce-4f4c-9752-23a055fdb324','a13af216-4409-5021-8dd5-255cc71bffc3','nba','2014-04-29 05:00:00','583ecfff-fb46-11e1-82cb-f4ce4684ea4c','583eca88-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('4c17fa95-218d-496c-ba64-0acc1c0fa638','792ec100-691e-5e16-8ef8-79b2b6ee38ba','nba','2014-04-30 02:30:00','583ecdfb-fb46-11e1-82cb-f4ce4684ea4c','583ec825-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('2176b807-6ae9-4df3-8835-f647362ed1dc','8a7580c0-4052-54d5-85cd-85aab6200acf','nba','2014-04-30 05:00:00','583ecd4f-fb46-11e1-82cb-f4ce4684ea4c','583ecf50-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('ad9d8932-fa3d-4135-a534-527fce453093','5b239206-57ce-50aa-baaa-627f3349dfdc','nba','2014-04-30 05:00:00','583ecb3a-fb46-11e1-82cb-f4ce4684ea4c','583ed056-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('c49e3b07-6230-47ee-bcff-dd1c01d52fe3','b67d5f09-28b2-5bc6-9097-af312007d2f4','nba','2014-04-30 05:00:00','583ecea6-fb46-11e1-82cb-f4ce4684ea4c','583ec97e-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('c4e6c865-bec1-4358-98d5-f58fc54d8d64','62cc9661-7b13-56e7-bf4a-bba7ad7be8da','nba','2014-04-30 05:00:00','583ecda6-fb46-11e1-82cb-f4ce4684ea4c','583ec9d6-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('bb0ca0ed-52c4-41fb-995d-f23ed57613c1','e25e21f2-1d67-5f13-910b-81fc8629eea7','nba','2014-05-01 05:00:00','583ec825-fb46-11e1-82cb-f4ce4684ea4c','583ecdfb-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('c8179120-cfb2-4a13-8588-b1bb376a8890','fd21f639-8a47-51ac-a5dd-590629d445cf','nba','2014-05-01 05:00:00','583ecb8f-fb46-11e1-82cb-f4ce4684ea4c','583ec7cd-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('f237894a-8727-4059-91ca-91b700ee904a','7657c204-a20b-527a-99cb-dc29218462aa','nba','2014-05-01 05:00:00','583eca88-fb46-11e1-82cb-f4ce4684ea4c','583ecfff-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('fd8a83da-835a-471d-a6b1-b7b6b07af60a','f62d5b49-d646-56e9-ba60-a875a00830f8','nba','2014-05-01 05:00:00','583ec8d4-fb46-11e1-82cb-f4ce4684ea4c','583ec5fd-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('1a6c5a19-d182-4738-9836-cf5377f89146','a380f011-6e5d-5430-9f37-209e1e8a9b6f','nba','2014-05-02 05:00:00','583ec97e-fb46-11e1-82cb-f4ce4684ea4c','583ecea6-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('28d41571-92af-4c6f-83af-50b4334dbb41','401ba62f-19b5-5bfc-84d6-021772943311','nba','2014-05-02 05:00:00','583ecf50-fb46-11e1-82cb-f4ce4684ea4c','583ecd4f-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('b9fd330a-d593-4225-ad3c-52ec97baee37','7a330bcd-ac0f-50ca-bc29-2460e5c476b3','nba','2014-05-02 05:00:00','583ec9d6-fb46-11e1-82cb-f4ce4684ea4c','583ecda6-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('e6583433-9b46-4114-a754-acd7d8dccceb','1d1f74a2-7b35-56f0-8cbd-552c51cb2c14','nba','2014-05-02 05:00:00','583ed056-fb46-11e1-82cb-f4ce4684ea4c','583ecb3a-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('275616d8-0f5a-48af-93b3-b918a4d51cf9','38911649-acfd-551a-949b-68f0fcaa44e7','nba','2014-05-03 05:00:00','583ec5fd-fb46-11e1-82cb-f4ce4684ea4c','583ec8d4-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('42b6a5ad-c0bd-4bb7-af6e-76f408f83aae','24bb478e-eb31-5f8a-8c8d-07f513169ec1','nba','2014-05-03 05:00:00','583ec7cd-fb46-11e1-82cb-f4ce4684ea4c','583ecb8f-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('673533ef-c3f9-43a0-9c21-e841dfce0b61','a13af216-4409-5021-8dd5-255cc71bffc3','nba','2014-05-03 05:00:00','583ecfff-fb46-11e1-82cb-f4ce4684ea4c','583eca88-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('695ffa2a-17e2-4c75-991d-a2436ba86767','792ec100-691e-5e16-8ef8-79b2b6ee38ba','nba','2014-05-03 05:00:00','583ecdfb-fb46-11e1-82cb-f4ce4684ea4c','583ec825-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('2180b1ee-350e-4c00-bb41-25b8301d1667','b67d5f09-28b2-5bc6-9097-af312007d2f4','nba','2014-05-04 05:00:00','583ecea6-fb46-11e1-82cb-f4ce4684ea4c','583ec97e-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('901c6c23-03a8-4ee4-96f1-038480f7e2c1','8a7580c0-4052-54d5-85cd-85aab6200acf','nba','2014-05-04 05:00:00','583ecd4f-fb46-11e1-82cb-f4ce4684ea4c','583ecf50-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('a1e978a2-31a0-47b4-b5b1-f90027dd5a0b','5b239206-57ce-50aa-baaa-627f3349dfdc','nba','2014-05-04 05:00:00','583ecb3a-fb46-11e1-82cb-f4ce4684ea4c','583ed056-fb46-11e1-82cb-f4ce4684ea4c');
INSERT INTO "gameTimeApp_game" VALUES('aa607197-e2ef-479a-b974-caf4fdd5ee5d','62cc9661-7b13-56e7-bf4a-bba7ad7be8da','nba','2014-05-04 05:00:00','583ecda6-fb46-11e1-82cb-f4ce4684ea4c','583ec9d6-fb46-11e1-82cb-f4ce4684ea4c');
CREATE TABLE "gameTimeApp_player" (
    "player_id" varchar(36) NOT NULL PRIMARY KEY,
    "team_id" varchar(36) NOT NULL REFERENCES "gameTimeApp_team" ("team_id"),
    "position" varchar(10) NOT NULL,
    "jersey" varchar(3),
    "first_name" varchar(50) NOT NULL,
    "last_name" varchar(50) NOT NULL,
    "weight" varchar(5),
    "height" varchar(1),
    "birth_date" date,
    "birth_city" varchar(30),
    "birth_state" varchar(2),
    "birth_country" varchar(30),
    "college" varchar(50)
);
CREATE TABLE "gameTimeApp_userinfo_gamesFollowing" (
    "id" integer NOT NULL PRIMARY KEY,
    "userinfo_id" integer NOT NULL,
    "game_id" varchar(36) NOT NULL REFERENCES "gameTimeApp_game" ("game_id"),
    UNIQUE ("userinfo_id", "game_id")
);
INSERT INTO "gameTimeApp_userinfo_gamesFollowing" VALUES(2,1,'13b7ede8-73a4-469d-ab6d-4187ff10d3a2');
INSERT INTO "gameTimeApp_userinfo_gamesFollowing" VALUES(3,1,'067a6e24-4594-47cc-afc0-2931a8c712bf');
INSERT INTO "gameTimeApp_userinfo_gamesFollowing" VALUES(4,1,'461f91b2-7ae2-44bb-99a6-11e17ee82c59');
INSERT INTO "gameTimeApp_userinfo_gamesFollowing" VALUES(5,2,'461f91b2-7ae2-44bb-99a6-11e17ee82c59');
INSERT INTO "gameTimeApp_userinfo_gamesFollowing" VALUES(6,2,'474d9c6c-9143-4b2d-9c23-12f1dc1a3299');
INSERT INTO "gameTimeApp_userinfo_gamesFollowing" VALUES(7,2,'13b7ede8-73a4-469d-ab6d-4187ff10d3a2');
INSERT INTO "gameTimeApp_userinfo_gamesFollowing" VALUES(8,5,'0de027fe-9c19-4558-842e-0acf4574b0fa');
INSERT INTO "gameTimeApp_userinfo_gamesFollowing" VALUES(10,5,'bd3b1b3e-ce9a-4336-bfb5-b76cc2e9519c');
INSERT INTO "gameTimeApp_userinfo_gamesFollowing" VALUES(11,4,'9733155c-2be5-4480-aa2c-0b2fc4d5ff43');
INSERT INTO "gameTimeApp_userinfo_gamesFollowing" VALUES(12,4,'9b56a88d-a923-42dc-ab9c-f3b9f32f28a0');
INSERT INTO "gameTimeApp_userinfo_gamesFollowing" VALUES(13,4,'0de027fe-9c19-4558-842e-0acf4574b0fa');
CREATE TABLE "gameTimeApp_post_likers" (
    "id" integer NOT NULL PRIMARY KEY,
    "post_id" integer NOT NULL,
    "user_id" integer NOT NULL REFERENCES "auth_user" ("id"),
    UNIQUE ("post_id", "user_id")
);
INSERT INTO "gameTimeApp_post_likers" VALUES(1,1,2);
INSERT INTO "gameTimeApp_post_likers" VALUES(2,2,2);
INSERT INTO "gameTimeApp_post_likers" VALUES(3,6,6);
INSERT INTO "gameTimeApp_post_likers" VALUES(4,6,5);
INSERT INTO "gameTimeApp_post_likers" VALUES(5,25,6);
INSERT INTO "gameTimeApp_post_likers" VALUES(6,40,6);
CREATE TABLE "gameTimeApp_question" (
    "id" integer NOT NULL PRIMARY KEY,
    "text" varchar(500) NOT NULL,
    "user_id" integer NOT NULL REFERENCES "auth_user" ("id"),
    "resolved" bool NOT NULL,
    "bounty" integer NOT NULL,
    "date" timestamp,
    "game_id" varchar(36) NOT NULL REFERENCES "gameTimeApp_game" ("game_id")
);
INSERT INTO "gameTimeApp_question" VALUES(1,'Hey.',2,1,0,'2014-04-22 21:58:58.230329','461f91b2-7ae2-44bb-99a6-11e17ee82c59');
INSERT INTO "gameTimeApp_question" VALUES(2,'??',2,1,0,'2014-04-23 03:26:28.959729','461f91b2-7ae2-44bb-99a6-11e17ee82c59');
INSERT INTO "gameTimeApp_question" VALUES(3,'????DDDD',2,1,0,'2014-04-23 03:40:03.768229','461f91b2-7ae2-44bb-99a6-11e17ee82c59');
INSERT INTO "gameTimeApp_question" VALUES(4,'yet another question.',2,1,0,'2014-04-23 03:50:07.391272','461f91b2-7ae2-44bb-99a6-11e17ee82c59');
INSERT INTO "gameTimeApp_question" VALUES(5,'one more!',2,1,100,'2014-04-23 03:50:15.104365','461f91b2-7ae2-44bb-99a6-11e17ee82c59');
INSERT INTO "gameTimeApp_question" VALUES(6,'one more....',2,1,20,'2014-04-23 04:07:25.172279','461f91b2-7ae2-44bb-99a6-11e17ee82c59');
INSERT INTO "gameTimeApp_question" VALUES(7,'No more..',2,1,5,'2014-04-23 04:17:52.664787','13b7ede8-73a4-469d-ab6d-4187ff10d3a2');
INSERT INTO "gameTimeApp_question" VALUES(8,'zzzz.',2,1,0,'2014-04-23 04:26:02.121427','13b7ede8-73a4-469d-ab6d-4187ff10d3a2');
INSERT INTO "gameTimeApp_question" VALUES(9,'zz..',2,1,20,'2014-04-23 04:27:35.494962','13b7ede8-73a4-469d-ab6d-4187ff10d3a2');
INSERT INTO "gameTimeApp_question" VALUES(10,'a.smd,as,md',2,1,0,'2014-04-23 04:32:36.589122','13b7ede8-73a4-469d-ab6d-4187ff10d3a2');
INSERT INTO "gameTimeApp_question" VALUES(11,'question',5,0,0,'2014-04-24 12:10:59.111983','0de027fe-9c19-4558-842e-0acf4574b0fa');
CREATE TABLE "gameTimeApp_response_voters" (
    "id" integer NOT NULL PRIMARY KEY,
    "response_id" integer NOT NULL,
    "user_id" integer NOT NULL REFERENCES "auth_user" ("id"),
    UNIQUE ("response_id", "user_id")
);
INSERT INTO "gameTimeApp_response_voters" VALUES(1,2,2);
INSERT INTO "gameTimeApp_response_voters" VALUES(2,8,2);
INSERT INTO "gameTimeApp_response_voters" VALUES(3,9,3);
INSERT INTO "gameTimeApp_response_voters" VALUES(4,10,3);
INSERT INTO "gameTimeApp_response_voters" VALUES(5,9,2);
INSERT INTO "gameTimeApp_response_voters" VALUES(6,10,2);
INSERT INTO "gameTimeApp_response_voters" VALUES(7,12,2);
INSERT INTO "gameTimeApp_response_voters" VALUES(8,13,2);
INSERT INTO "gameTimeApp_response_voters" VALUES(9,14,3);
CREATE TABLE "gameTimeApp_response" (
    "id" integer NOT NULL PRIMARY KEY,
    "text" varchar(500) NOT NULL,
    "user_id" integer NOT NULL REFERENCES "auth_user" ("id"),
    "date" timestamp,
    "post_id" integer REFERENCES "gameTimeApp_post" ("id"),
    "question_id" integer REFERENCES "gameTimeApp_question" ("id"),
    "best_answer" bool,
    "picture" varchar(100) NOT NULL,
    "votes" integer
);
INSERT INTO "gameTimeApp_response" VALUES(1,'Maybe..',2,'2014-04-22 21:58:42.748733',1,NULL,NULL,'',NULL);
INSERT INTO "gameTimeApp_response" VALUES(2,'this is an answer.',2,'2014-04-22 21:59:11.997921',NULL,1,0,'',1);
INSERT INTO "gameTimeApp_response" VALUES(3,'Hew.',2,'2014-04-22 22:29:33.019093',1,NULL,NULL,'',NULL);
INSERT INTO "gameTimeApp_response" VALUES(4,'well',2,'2014-04-23 01:23:34.361702',2,NULL,NULL,'',NULL);
INSERT INTO "gameTimeApp_response" VALUES(5,'hmm',2,'2014-04-23 01:30:00.268396',2,NULL,NULL,'',NULL);
INSERT INTO "gameTimeApp_response" VALUES(6,'testing',2,'2014-04-23 01:41:40.312240',3,NULL,NULL,'',NULL);
INSERT INTO "gameTimeApp_response" VALUES(7,'d',2,'2014-04-23 01:42:38.621180',2,NULL,NULL,'',NULL);
INSERT INTO "gameTimeApp_response" VALUES(8,'maybe.',2,'2014-04-23 02:20:35.819609',NULL,1,1,'',-1);
INSERT INTO "gameTimeApp_response" VALUES(9,'well',2,'2014-04-23 03:26:35.730470',NULL,2,0,'',2);
INSERT INTO "gameTimeApp_response" VALUES(10,'Because..',3,'2014-04-23 03:30:40.963305',NULL,2,1,'',2);
INSERT INTO "gameTimeApp_response" VALUES(11,'kdjk',2,'2014-04-23 03:37:57.849449',NULL,2,0,'game-photos/IMG_0052.JPG',0);
INSERT INTO "gameTimeApp_response" VALUES(12,'!!!!because..',3,'2014-04-23 03:40:38.009646',NULL,3,1,'',1);
INSERT INTO "gameTimeApp_response" VALUES(13,'wel..',2,'2014-04-23 03:50:25.187554',NULL,5,0,'',1);
INSERT INTO "gameTimeApp_response" VALUES(14,'select me!',3,'2014-04-23 03:51:24.926307',NULL,5,1,'',1);
INSERT INTO "gameTimeApp_response" VALUES(15,'select me!',3,'2014-04-23 03:58:40.669234',NULL,4,1,'',0);
INSERT INTO "gameTimeApp_response" VALUES(16,'again me.',3,'2014-04-23 04:09:22.544127',NULL,6,1,'',0);
INSERT INTO "gameTimeApp_response" VALUES(17,'me again.',3,'2014-04-23 04:18:38.735749',NULL,7,1,'',0);
INSERT INTO "gameTimeApp_response" VALUES(18,'hey its me.',3,'2014-04-23 04:26:30.383288',NULL,8,1,'',0);
INSERT INTO "gameTimeApp_response" VALUES(19,'my turn.',2,'2014-04-23 04:27:57.518327',NULL,9,0,'',0);
INSERT INTO "gameTimeApp_response" VALUES(20,'d',3,'2014-04-23 04:28:38.707013',NULL,9,1,'',0);
INSERT INTO "gameTimeApp_response" VALUES(21,'w',3,'2014-04-23 04:33:00.012473',NULL,10,1,'',0);
INSERT INTO "gameTimeApp_response" VALUES(22,'response',6,'2014-04-24 22:40:45.948338',13,NULL,NULL,'',NULL);
INSERT INTO "gameTimeApp_response" VALUES(23,'response',5,'2014-04-24 22:48:30.561433',14,NULL,NULL,'',NULL);
INSERT INTO "gameTimeApp_response" VALUES(24,'a',6,'2014-04-24 23:02:01.768776',15,NULL,NULL,'',NULL);
INSERT INTO "gameTimeApp_response" VALUES(25,'response',5,'2014-04-24 23:02:39.522967',14,NULL,NULL,'',NULL);
INSERT INTO "gameTimeApp_response" VALUES(26,'response',5,'2014-04-24 23:07:10.014798',14,NULL,NULL,'',NULL);
INSERT INTO "gameTimeApp_response" VALUES(27,'response',5,'2014-04-24 23:10:19.624274',14,NULL,NULL,'',NULL);
INSERT INTO "gameTimeApp_response" VALUES(28,'response',5,'2014-04-24 23:14:02.052062',14,NULL,NULL,'',NULL);
INSERT INTO "gameTimeApp_response" VALUES(29,'response',5,'2014-04-24 23:14:57.956004',22,NULL,NULL,'',NULL);
CREATE TABLE "south_migrationhistory" (
    "id" integer NOT NULL PRIMARY KEY,
    "app_name" varchar(255) NOT NULL,
    "migration" varchar(255) NOT NULL,
    "applied" timestamp NOT NULL
);
INSERT INTO "south_migrationhistory" VALUES(1,'gameTimeApp','0001_initial','2014-04-22 21:55:54.025716');
INSERT INTO "south_migrationhistory" VALUES(2,'gameTimeApp','0002_auto__chg_field_userinfo_user__add_unique_userinfo_user','2014-04-23 23:22:36.857837');
CREATE TABLE "gameTimeApp_userinfo" ("reputation" integer NOT NULL, "user_id" integer NOT NULL UNIQUE UNIQUE, "id" integer PRIMARY KEY, "confirmKey" varchar(100) NOT NULL);
INSERT INTO "gameTimeApp_userinfo" VALUES(10,2,1,'59250583215612');
INSERT INTO "gameTimeApp_userinfo" VALUES(155,3,2,'89718883739858');
INSERT INTO "gameTimeApp_userinfo" VALUES(10,4,3,'50003579382246');
INSERT INTO "gameTimeApp_userinfo" VALUES(10,5,4,'8422465482439');
INSERT INTO "gameTimeApp_userinfo" VALUES(10,6,5,'84162002484080');
CREATE TABLE "gameTimeApp_post" ("picture" varchar(100) NOT NULL, "user_id" integer NOT NULL, "text" varchar(500) NOT NULL, "date" timestamp, "game_id" varchar(36) NOT NULL, "id" integer PRIMARY KEY);
INSERT INTO "gameTimeApp_post" VALUES('',2,'Whats up?','2014-04-22 21:58:33.185934','461f91b2-7ae2-44bb-99a6-11e17ee82c59',1);
INSERT INTO "gameTimeApp_post" VALUES('',2,'Whats up again?','2014-04-22 22:33:17.674442','13b7ede8-73a4-469d-ab6d-4187ff10d3a2',2);
INSERT INTO "gameTimeApp_post" VALUES('game-photos/IMG_0384.JPG',2,'Hew','2014-04-22 22:39:04.401196','461f91b2-7ae2-44bb-99a6-11e17ee82c59',3);
INSERT INTO "gameTimeApp_post" VALUES('',2,'???DDD???','2014-04-23 03:39:57.791791','461f91b2-7ae2-44bb-99a6-11e17ee82c59',4);
INSERT INTO "gameTimeApp_post" VALUES('',5,'when is the game starting','2014-04-24 11:52:40.149102','0de027fe-9c19-4558-842e-0acf4574b0fa',5);
INSERT INTO "gameTimeApp_post" VALUES('game-photos/Screen_Shot_2014-04-07_at_12.39.50_PM_1.png',6,'when is the game ending?','2014-04-24 12:03:47.176652','0de027fe-9c19-4558-842e-0acf4574b0fa',6);
INSERT INTO "gameTimeApp_post" VALUES('',6,'game comment','2014-04-24 22:19:06.933060','0de027fe-9c19-4558-842e-0acf4574b0fa',7);
INSERT INTO "gameTimeApp_post" VALUES('',6,'a','2014-04-24 22:21:31.420295','0de027fe-9c19-4558-842e-0acf4574b0fa',8);
INSERT INTO "gameTimeApp_post" VALUES('',6,'a','2014-04-24 22:27:06.854549','0de027fe-9c19-4558-842e-0acf4574b0fa',9);
INSERT INTO "gameTimeApp_post" VALUES('',6,'a','2014-04-24 22:36:10.231740','0de027fe-9c19-4558-842e-0acf4574b0fa',10);
INSERT INTO "gameTimeApp_post" VALUES('',6,'comment','2014-04-24 22:36:37.658037','0de027fe-9c19-4558-842e-0acf4574b0fa',11);
INSERT INTO "gameTimeApp_post" VALUES('',6,'post comment','2014-04-24 22:39:56.301750','0de027fe-9c19-4558-842e-0acf4574b0fa',12);
INSERT INTO "gameTimeApp_post" VALUES('',5,'comment','2014-04-24 22:40:26.859716','0de027fe-9c19-4558-842e-0acf4574b0fa',13);
INSERT INTO "gameTimeApp_post" VALUES('',6,'comment','2014-04-24 22:48:08.602465','0de027fe-9c19-4558-842e-0acf4574b0fa',14);
INSERT INTO "gameTimeApp_post" VALUES('',6,'blogPost','2014-04-24 22:54:54.028823','0de027fe-9c19-4558-842e-0acf4574b0fa',15);
INSERT INTO "gameTimeApp_post" VALUES('',6,'blogComment','2014-04-24 23:02:29.549626','0de027fe-9c19-4558-842e-0acf4574b0fa',16);
INSERT INTO "gameTimeApp_post" VALUES('',6,'blog post ','2014-04-24 23:02:48.177241','0de027fe-9c19-4558-842e-0acf4574b0fa',17);
INSERT INTO "gameTimeApp_post" VALUES('',6,'blog comment','2014-04-24 23:07:16.581591','0de027fe-9c19-4558-842e-0acf4574b0fa',18);
INSERT INTO "gameTimeApp_post" VALUES('',6,'blog comment','2014-04-24 23:08:20.112673','0de027fe-9c19-4558-842e-0acf4574b0fa',19);
INSERT INTO "gameTimeApp_post" VALUES('',6,'blog post ','2014-04-24 23:10:28.347977','0de027fe-9c19-4558-842e-0acf4574b0fa',20);
INSERT INTO "gameTimeApp_post" VALUES('',6,'abc','2014-04-24 23:12:47.830074','0de027fe-9c19-4558-842e-0acf4574b0fa',21);
INSERT INTO "gameTimeApp_post" VALUES('',6,'abcdef','2014-04-24 23:14:17.938938','0de027fe-9c19-4558-842e-0acf4574b0fa',22);
INSERT INTO "gameTimeApp_post" VALUES('',6,'post','2014-04-25 00:08:15.653373','0de027fe-9c19-4558-842e-0acf4574b0fa',23);
INSERT INTO "gameTimeApp_post" VALUES('',6,'comment','2014-04-25 00:10:34.191849','0de027fe-9c19-4558-842e-0acf4574b0fa',24);
INSERT INTO "gameTimeApp_post" VALUES('',5,'blog post ','2014-04-25 00:20:55.265720','0de027fe-9c19-4558-842e-0acf4574b0fa',25);
INSERT INTO "gameTimeApp_post" VALUES('',6,'comment','2014-04-25 00:26:08.348343','0de027fe-9c19-4558-842e-0acf4574b0fa',26);
INSERT INTO "gameTimeApp_post" VALUES('',5,'blog post ','2014-04-25 00:26:17.659776','0de027fe-9c19-4558-842e-0acf4574b0fa',27);
INSERT INTO "gameTimeApp_post" VALUES('',5,'blog comment post','2014-04-25 00:26:25.682967','0de027fe-9c19-4558-842e-0acf4574b0fa',28);
INSERT INTO "gameTimeApp_post" VALUES('',6,'comment','2014-04-25 00:26:52.229670','0de027fe-9c19-4558-842e-0acf4574b0fa',29);
INSERT INTO "gameTimeApp_post" VALUES('',5,'post','2014-04-25 00:26:59.211079','0de027fe-9c19-4558-842e-0acf4574b0fa',30);
INSERT INTO "gameTimeApp_post" VALUES('',6,'comment','2014-04-25 00:27:45.095666','0de027fe-9c19-4558-842e-0acf4574b0fa',31);
INSERT INTO "gameTimeApp_post" VALUES('',6,'post','2014-04-25 00:29:08.106755','0de027fe-9c19-4558-842e-0acf4574b0fa',32);
INSERT INTO "gameTimeApp_post" VALUES('',5,'post','2014-04-25 00:31:49.748506','0de027fe-9c19-4558-842e-0acf4574b0fa',33);
INSERT INTO "gameTimeApp_post" VALUES('',6,'post','2014-04-25 00:31:55.454912','0de027fe-9c19-4558-842e-0acf4574b0fa',34);
INSERT INTO "gameTimeApp_post" VALUES('',5,'comment','2014-04-25 00:32:03.524648','0de027fe-9c19-4558-842e-0acf4574b0fa',35);
INSERT INTO "gameTimeApp_post" VALUES('',6,'post','2014-04-25 00:34:12.440306','0de027fe-9c19-4558-842e-0acf4574b0fa',36);
INSERT INTO "gameTimeApp_post" VALUES('',5,'comment','2014-04-25 00:34:15.058232','0de027fe-9c19-4558-842e-0acf4574b0fa',37);
INSERT INTO "gameTimeApp_post" VALUES('',6,'post','2014-04-25 00:34:28.571220','0de027fe-9c19-4558-842e-0acf4574b0fa',38);
INSERT INTO "gameTimeApp_post" VALUES('',5,'post','2014-04-25 00:34:32.682390','0de027fe-9c19-4558-842e-0acf4574b0fa',39);
INSERT INTO "gameTimeApp_post" VALUES('',5,'blog post','2014-04-25 00:34:48.572139','0de027fe-9c19-4558-842e-0acf4574b0fa',40);
INSERT INTO "gameTimeApp_post" VALUES('',5,'blog post','2014-04-25 00:36:58.832819','0de027fe-9c19-4558-842e-0acf4574b0fa',41);
INSERT INTO "gameTimeApp_post" VALUES('',6,'post','2014-04-25 00:37:04.671006','0de027fe-9c19-4558-842e-0acf4574b0fa',42);
INSERT INTO "gameTimeApp_post" VALUES('',5,'blog post','2014-04-25 00:37:10.718990','0de027fe-9c19-4558-842e-0acf4574b0fa',43);
INSERT INTO "gameTimeApp_post" VALUES('',5,'post','2014-04-25 00:42:08.390882','0de027fe-9c19-4558-842e-0acf4574b0fa',44);
INSERT INTO "gameTimeApp_post" VALUES('',5,'new post ','2014-04-25 00:43:10.329132','0de027fe-9c19-4558-842e-0acf4574b0fa',45);
INSERT INTO "gameTimeApp_post" VALUES('',6,'post','2014-04-25 00:43:17.771837','0de027fe-9c19-4558-842e-0acf4574b0fa',46);
CREATE INDEX "django_admin_log_6340c63c" ON "django_admin_log" ("user_id");
CREATE INDEX "django_admin_log_37ef4eb4" ON "django_admin_log" ("content_type_id");
CREATE INDEX "auth_permission_37ef4eb4" ON "auth_permission" ("content_type_id");
CREATE INDEX "auth_group_permissions_5f412f9a" ON "auth_group_permissions" ("group_id");
CREATE INDEX "auth_group_permissions_83d7f98b" ON "auth_group_permissions" ("permission_id");
CREATE INDEX "auth_user_groups_6340c63c" ON "auth_user_groups" ("user_id");
CREATE INDEX "auth_user_groups_5f412f9a" ON "auth_user_groups" ("group_id");
CREATE INDEX "auth_user_user_permissions_6340c63c" ON "auth_user_user_permissions" ("user_id");
CREATE INDEX "auth_user_user_permissions_83d7f98b" ON "auth_user_user_permissions" ("permission_id");
CREATE INDEX "django_session_b7b81f0c" ON "django_session" ("expire_date");
CREATE INDEX "gameTimeApp_team_03eb0938" ON "gameTimeApp_team" ("venue_id");
CREATE INDEX "gameTimeApp_game_03eb0938" ON "gameTimeApp_game" ("venue_id");
CREATE INDEX "gameTimeApp_game_d48a77b0" ON "gameTimeApp_game" ("home_team_id");
CREATE INDEX "gameTimeApp_game_c5009960" ON "gameTimeApp_game" ("away_team_id");
CREATE INDEX "gameTimeApp_player_95e8aaa1" ON "gameTimeApp_player" ("team_id");
CREATE INDEX "gameTimeApp_userinfo_gamesFollowing_8835ac30" ON "gameTimeApp_userinfo_gamesFollowing" ("userinfo_id");
CREATE INDEX "gameTimeApp_userinfo_gamesFollowing_65e12249" ON "gameTimeApp_userinfo_gamesFollowing" ("game_id");
CREATE INDEX "gameTimeApp_post_likers_87a49a9a" ON "gameTimeApp_post_likers" ("post_id");
CREATE INDEX "gameTimeApp_post_likers_6340c63c" ON "gameTimeApp_post_likers" ("user_id");
CREATE INDEX "gameTimeApp_question_6340c63c" ON "gameTimeApp_question" ("user_id");
CREATE INDEX "gameTimeApp_question_65e12249" ON "gameTimeApp_question" ("game_id");
CREATE INDEX "gameTimeApp_response_voters_62820ff2" ON "gameTimeApp_response_voters" ("response_id");
CREATE INDEX "gameTimeApp_response_voters_6340c63c" ON "gameTimeApp_response_voters" ("user_id");
CREATE INDEX "gameTimeApp_response_6340c63c" ON "gameTimeApp_response" ("user_id");
CREATE INDEX "gameTimeApp_response_87a49a9a" ON "gameTimeApp_response" ("post_id");
CREATE INDEX "gameTimeApp_response_25110688" ON "gameTimeApp_response" ("question_id");
CREATE UNIQUE INDEX "gameTimeApp_userinfo_user_id" ON "gameTimeApp_userinfo"("user_id");
CREATE INDEX "gameTimeApp_post_65e12249" ON "gameTimeApp_post"("game_id");
CREATE INDEX "gameTimeApp_post_6340c63c" ON "gameTimeApp_post"("user_id");
COMMIT;
