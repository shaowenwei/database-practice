CREATE TABLE USERS(
	USER_ID NUMBER,
	FIRST_NAME VARCHAR2(100) NOT NULL,
	LAST_NAME VARCHAR2(100) NOT NULL,
	YEAR_OF_BIRTH INTEGER,
	MONTH_OF_BIRTH INTEGER,
	DAY_OF_BIRTH INTEGER,
	GENDER VARCHAR2(100),
	PRIMARY KEY(USER_ID)
);

CREATE TABLE FRIENDS(
	USER1_ID NUMBER,
	USER2_ID NUMBER,
	UNIQUE(USER1_ID, USER2_ID)
	FOREIGN KEY(USER1_ID) REFERENCES USERS(USER_ID),
	FOREIGN KEY(USER2_ID) REFERENCES USERS(USER_ID)	
);

CREATE TABLE CITIES(
	CITY_ID INTEGER,
	CITY_NAME VARCHAR2(100),
	STATE_NAME VARCHAR2(100),
	COUNTRY_NAME VARCHAR2(100),
	PRIMARY KEY(CITY_ID)
);

CREATE TABLE USER_CURRENT_CITY(
	USER_ID NUMBER,
	CURRENT_CITY_ID INTEGER,
	UNIQUE(USER_ID),
	FOREIGN KEY(USER_ID) REFERENCES USERS(USER_ID),
	FOREIGN KEY(CURRENT_CITY_ID) REFERENCES CITIES(CITY_ID)
);

CREATE TABLE USER_HOMETOWN_CITY(
	USER_ID NUMBER,
	HOMETOWN_CITY_ID INTEGER,
	UNIQUE(USER_ID),
	FOREIGN KEY(USER_ID) REFERENCES USERS(USER_ID),
	FOREIGN KEY(HOMETOWN_CITY_ID) REFERENCES CITIES(CITY_ID)
);

CREATE TABLE MESSAGE(
	MESSAGE_ID INTEGER,
	SENDER_ID NUMBER,
	RECEIVER_ID NUMBER,
	MESSAGE_CONTENT VARCHAR2(2000),
	SENT_TIME TIMESTAMP,
	PRIMARY KEY(MESSAGE_ID),
	FOREIGN KEY(SENDER_ID) REFERENCES USERS(USER_ID),
	FOREIGN KEY(RECEIVER_ID) REFERENCES USERS(USER_ID)
);

CREATE TABLE PROGRAMS(
	PROGRAM_ID INTEGER,
	INSTITUTION VARCHAR2(100),
	CONCENTRATION VARCHAR2(100),
	DEGREE VARCHAR2(100),
	PRIMARY KEY(PROGRAM_ID)
);

CREATE TABLE EDUCATION(
	USER_ID NUMBER,
	PROGRAM_ID INTEGER,
	PROGRAM_YEAR INTEGER,
	FOREIGN KEY(USER_ID) REFERENCES USERS(USER_ID),
	FOREIGN KEY(PROGRAM_ID) REFERENCES PROGRAMS(PROGRAM_ID)	
);

CREATE TABLE USER_EVENTS(
	EVENT_ID NUMBER, 
	EVENT_CREATOR_ID NUMBER,
	EVENT_NAME VARCHAR2(100),
	EVENT_TAGLINE VARCHAR2(100),
	EVENT_DESCRIPTION VARCHAR2(100),
	EVENT_HOST VARCHAR2(100),
	EVENT_TYPE VARCHAR2(100),
	EVENT_SUBTYPE VARCHAR2(100),
	EVENT_LOCATION VARCHAR2(100),
	EVENT_CITY_ID INTEGER,
	EVENT_START_TIME TIMESTAMP, 
	EVENT_END_TIME TIMESTAMP,
	PRIMARY KEY(EVENT_ID),
	FOREIGN KEY(EVENT_CREATOR_ID) REFERENCES USERS(USER_ID)
);

CREATE TABLE PARTICIPANTS(
	EVENT_ID NUMBER,
	USER_ID NUMBER,
	CONFIRMATION VARCHAR2(100),
	FOREIGN KEY(EVENT_ID) REFERENCES USER_EVENTS(EVENT_ID),
	FOREIGN KEY(USER_ID) REFERENCES USERS(USER_ID)
);

CREATE TABLE ALBUMS(
	ALBUM_ID VARCHAR2(100),
	ALBUM_OWNER_ID NUMBER,
	ALBUM_NAME VARCHAR2(100),
	ALBUM_CREATED_TIME TIMESTAMP,
	ALBUM_MODIFIED_TIME TIMESTAMP,
	ALBUM_LINK VARCHAR2(2000),
	ALBUM_VISIBILITY VARCHAR2(100),
	COVER_PHOTO_ID VARCHAR2(100) NOT NULL,
	PRIMARY KEY(ALBUM_ID),
	FOREIGN KEY(ALBUM_OWNER_ID) REFERENCES USERS(USER_ID),
	FOREIGN KEY(COVER_PHOTO_ID) REFERENCES PHOTOS(PHOTO_ID)	
);

CREATE TABLE PHOTOS(
	PHOTO_ID VARCHAR2(100),
	ALBUM_ID VARCHAR2(100),
	PHOTO_CAPTION VARCHAR2(2000),
	PHOTO_CREATED_TIME TIMESTAMP,
	PHOTO_MODIFIED_TIME TIMESTAMP,
	PHOTO_LINK VARCHAR2(2000),
	PRIMARY KEY(PHOTO_ID),
	FOREIGN KEY(ALBUM_ID) REFERENCES ALBUMS(ALBUM_ID)

);

CREATE TABLE TAGS(
	TAG_PHOTO_ID VARCHAR2(100),
	TAG_SUBJECT_ID NUMBER,
	TAG_CREATED_TIME TIMESTAMP,
	TAG_X NUMBER,
	TAG_Y NUMBER,
	FOREIGN KEY(TAG_PHOTO_ID) REFERENCES PHOTOS(PHOTO_ID),
	FOREIGN KEY(TAG_SUBJECT_ID) REFERENCES USERS(USER_ID)	
);