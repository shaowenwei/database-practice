
INSERT INTO USERS(USER_ID, FIRST_NAME, LAST_NAME, YEAR_OF_BIRTH, MONTH_OF_BIRTH, DAY_OF_BIRTH, GENDER)
SELECT DISTINCT USER_ID, FIRST_NAME, LAST_NAME, YEAR_OF_BIRTH, MONTH_OF_BIRTH, DAY_OF_BIRTH, GENDER
FROM USER_INFORMATION;

INSERT INTO FRIENDS(USER1_ID, USER2_ID)
SELECT DISTINCT USER1_ID, USER2_ID 
FROM ARE_FRIENDS
WHERE USER1_ID < USER2_ID;

INSERT INTO FRIENDS(USER1_ID, USER2_ID)
SELECT DISTINCT USER2_ID, USER1_ID 
FROM ARE_FRIENDS
WHERE USER1_ID > USER2_ID;

INSERT INTO CITIES(CITY_NAME, STATE_NAME, COUNTRY_NAME)
SELECT DISTINCT HOMETOWN_CITY, HOMETOWN_STATE, HOMETOWN_COUNTRY 
FROM USER_INFORMATION
UNION
SELECT DISTINCT CURRENT_CITY, CURRENT_STATE, CURRENT_COUNTRY 
FROM USER_INFORMATION
UNION
SELECT DISTINCT EVENT_CITY, EVENT_STATE, EVENT_COUNTRY 
FROM EVENT_INFORMATION;

DELETE FROM CITIES WHERE CITY_NAME IS NULL AND STATE_NAME IS NULL AND COUNTRY_NAME IS NULL; 

INSERT INTO USER_CURRENT_CITY(USER_ID, CURRENT_CITY_ID)
SELECT DISTINCT U.USER_ID, C.CITY_ID
FROM USER_INFORMATION U, CITIES C
WHERE (U.CURRENT_CITY=C.CITY_NAME AND U.CURRENT_STATE=C.STATE_NAME AND U.CURRENT_COUNTRY=C.COUNTRY_NAME);

INSERT INTO USER_HOMETOWN_CITY(USER_ID, HOMETOWN_CITY_ID)
SELECT DISTINCT U.USER_ID, C.CITY_ID
FROM USER_INFORMATION U, CITIES C
WHERE (U.HOMETOWN_CITY=C.CITY_NAME AND U.HOMETOWN_STATE=C.STATE_NAME AND U.HOMETOWN_COUNTRY=C.COUNTRY_NAME);

INSERT INTO PROGRAMS(INSTITUTION, CONCENTRATION, DEGREE)
SELECT DISTINCT INSTITUTION_NAME, PROGRAM_CONCENTRATION, PROGRAM_DEGREE
FROM USER_INFORMATION

INSERT INTO PROGRAMS(INSTITUTION, CONCENTRATION, DEGREE)
VALUES("SSXSX")

DELETE FROM PROGRAMS WHERE INSTITUTION IS NULL AND CONCENTRATION IS NULL AND DEGREE IS NULL;

INSERT INTO EDUCATION(USER_ID, PROGRAM_ID, PROGRAM_YEAR)
SELECT U.USER_ID, P.PROGRAM_ID, U.PROGRAM_YEAR
FROM USER_INFORMATION U, PROGRAMS P
WHERE (U.INSTITUTION_NAME=P.INSTITUTION AND U.PROGRAM_CONCENTRATION=P.CONCENTRATION AND U.PROGRAM_DEGREE=P.DEGREE);

INSERT INTO USER_EVENTS(EVENT_ID, EVENT_CREATOR_ID, EVENT_NAME, EVENT_TAGLINE, EVENT_DESCRIPTION, EVENT_HOST, EVENT_TYPE, EVENT_SUBTYPE, EVENT_LOCATION, EVENT_CITY_ID, EVENT_START_TIME, EVENT_END_TIME)
SELECT E.EVENT_ID, E.EVENT_CREATOR_ID, E.EVENT_NAME, E.EVENT_TAGLINE, E.EVENT_DESCRIPTION, E.EVENT_HOST, E.EVENT_TYPE, E.EVENT_SUBTYPE, E.EVENT_LOCATION, C.CITY_ID, E.EVENT_START_TIME, E.EVENT_END_TIME
FROM EVENT_INFORMATION E, CITIES C
WHERE (E.EVENT_CITY=C.CITY_NAME AND E.EVENT_STATE=C.STATE_NAME AND E.EVENT_COUNTRY=C.COUNTRY_NAME);

SET AUTOCOMMIT OFF

INSERT INTO ALBUMS(ALBUM_ID, ALBUM_OWNER_ID, COVER_PHOTO_ID, ALBUM_NAME, ALBUM_CREATED_TIME, ALBUM_MODIFIED_TIME, ALBUM_LINK, ALBUM_VISIBILITY)
SELECT DISTINCT ALBUM_ID, OWNER_ID, COVER_PHOTO_ID, ALBUM_NAME, ALBUM_CREATED_TIME, ALBUM_MODIFIED_TIME, ALBUM_LINK, ALBUM_VISIBILITY
FROM PHOTO_INFORMATION;

INSERT INTO PHOTOS(PHOTO_ID, ALBUM_ID, PHOTO_CAPTION, PHOTO_CREATED_TIME, PHOTO_MODIFIED_TIME, PHOTO_LINK)
SELECT DISTINCT PHOTO_ID, ALBUM_ID, PHOTO_CAPTION, PHOTO_CREATED_TIME, PHOTO_MODIFIED_TIME, PHOTO_LINK
FROM PHOTO_INFORMATION;

COMMIT
SET AUTOCOMMIT ON

INSERT INTO TAGS(TAG_PHOTO_ID, TAG_SUBJECT_ID, TAG_CREATED_TIME, TAG_X, TAG_Y)
SELECT DISTINCT PHOTO_ID, TAG_SUBJECT_ID, TAG_CREATED_TIME, TAG_X_COORDINATE, TAG_Y_COORDINATE
FROM TAG_INFORMATION;









