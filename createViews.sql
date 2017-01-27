CREATE VIEW VIEW_USER_INFORMATION
(USER_ID, FIRST_NAME, LAST_NAME, YEAR_OF_BIRTH, MONTH_OF_BIRTH, DAY_OF_BIRTH, GENDER,
CURRENT_CITY, CURRENT_STATE, CURRENT_COUNTRY, 
HOMETOWN_CITY, HOMETOWN_STATE, HOMETOWN_COUNTRY,
INSTITUTION_NAME, PROGRAM_YEAR, PROGRAM_CONCENTRATION, PROGRAM_DEGREE) 
AS SELECT EP.USER_ID, UC.FIRST_NAME, UC.LAST_NAME, UC.YEAR_OF_BIRTH, UC.MONTH_OF_BIRTH, UC.DAY_OF_BIRTH, UC.GENDER, UC.CU_CITY, UC.CU_STATE, UC.CU_COUNTRY, UC.HC_CITY, UC.HC_STATE, UC.HC_COUNTRY, EP.INSTITUTION, EP.PROGRAM_YEAR, EP.CONCENTRATION, EP.DEGREE
FROM((
	SELECT UCCU.USER_ID, UCCU.FIRST_NAME, UCCU.LAST_NAME, UCCU.YEAR_OF_BIRTH, UCCU.MONTH_OF_BIRTH, UCCU.DAY_OF_BIRTH, UCCU.GENDER, UCCU.CITY_NAME AS CU_CITY, UCCU.STATE_NAME AS CU_STATE, UCCU.COUNTRY_NAME AS CU_COUNTRY, UCHC.CITY_NAME AS HC_CITY, UCHC.STATE_NAME AS HC_STATE, UCHC.COUNTRY_NAME AS HC_COUNTRY
	FROM((
		SELECT U.USER_ID, U.FIRST_NAME, U.LAST_NAME, U.YEAR_OF_BIRTH, U.MONTH_OF_BIRTH, U.DAY_OF_BIRTH, U.GENDER, CCU.CITY_NAME, CCU.STATE_NAME, CCU.COUNTRY_NAME
		FROM USERS U
		LEFT JOIN(
			SELECT CU.USER_ID, C1.CITY_NAME, C1.STATE_NAME, C1.COUNTRY_NAME
			FROM USER_CURRENT_CITY CU
			LEFT JOIN CITIES C1
			ON C1.CITY_ID = CU.CURRENT_CITY_ID
		)CCU
		ON CCU.USER_ID = U.USER_ID)UCCU)
		LEFT JOIN((
		SELECT U.USER_ID, U.FIRST_NAME, U.LAST_NAME, U.YEAR_OF_BIRTH, U.MONTH_OF_BIRTH, U.DAY_OF_BIRTH, U.GENDER, CHC.CITY_NAME, CHC.STATE_NAME, CHC.COUNTRY_NAME
		FROM USERS U
		LEFT JOIN(
			SELECT HC.USER_ID, C2.CITY_NAME, C2.STATE_NAME, C2.COUNTRY_NAME
			FROM USER_HOMETOWN_CITY HC
			LEFT JOIN CITIES C2
			ON C2.CITY_ID = HC.HOMETOWN_CITY_ID
			)CHC
		ON CHC.USER_ID = U.USER_ID)UCHC)
ON UCHC.USER_ID = UCCU.USER_ID)UC)
LEFT JOIN( 
	SELECT E.USER_ID, E.PROGRAM_YEAR, P.INSTITUTION, P.CONCENTRATION, P.DEGREE
	FROM EDUCATION E
	LEFT JOIN PROGRAMS P
	ON P.PROGRAM_ID = E.PROGRAM_ID
)EP
ON EP.USER_ID = UC.USER_ID

CREATE VIEW VIEW_ARE_FRIENDS(USER1_ID, USER2_ID)
AS SELECT USER1_ID, USER2_ID
FROM FRIENDS;

CREATE VIEW VIEW_PHOTO_INFORMATION
(ALBUM_ID, OWNER_ID, COVER_PHOTO_ID, ALBUM_NAME, ALBUM_CREATED_TIME, ALBUM_MODIFIED_TIME, ALBUM_LINK, ALBUM_VISIBILITY,
PHOTO_ID, PHOTO_CAPTION, PHOTO_CREATED_TIME, PHOTO_MODIFIED_TIME, PHOTO_LINK)
AS SELECT 
P.ALBUM_ID, A.ALBUM_OWNER_ID, A.COVER_PHOTO_ID, A.ALBUM_NAME, A.ALBUM_CREATED_TIME, A.ALBUM_MODIFIED_TIME, A.ALBUM_LINK, A.ALBUM_VISIBILITY,
P.PHOTO_ID, P.PHOTO_CAPTION, P.PHOTO_CREATED_TIME, P.PHOTO_MODIFIED_TIME, P.PHOTO_LINK
FROM ALBUMS A, PHOTOS P
WHERE 
P.ALBUM_ID=A.ALBUM_ID;

CREATE VIEW VIEW_TAG_INFORMATION(PHOTO_ID, TAG_SUBJECT_ID, TAG_CREATED_TIME, TAG_X_COORDINATE, TAG_Y_COORDINATE)
AS SELECT TAG_PHOTO_ID, TAG_SUBJECT_ID, TAG_CREATED_TIME, TAG_X, TAG_Y
FROM TAGS;

CREATE VIEW VIEW_EVENT_INFORMATION(EVENT_ID, EVENT_CREATOR_ID, EVENT_NAME, EVENT_TAGLINE, EVENT_DESCRIPTION, EVENT_HOST, EVENT_TYPE, EVENT_SUBTYPE, EVENT_LOCATION, 
EVENT_CITY, EVENT_STATE, EVENT_COUNTRY, EVENT_START_TIME, EVENT_END_TIME)
AS SELECT E.EVENT_ID, E.EVENT_CREATOR_ID, E.EVENT_NAME, E.EVENT_TAGLINE, E.EVENT_DESCRIPTION, E.EVENT_HOST, E.EVENT_TYPE, E.EVENT_SUBTYPE, E.EVENT_LOCATION,
C.CITY_NAME, C.STATE_NAME, C.COUNTRY_NAME, E.EVENT_START_TIME, E.EVENT_END_TIME
FROM USER_EVENTS E, CITIES C
WHERE E.EVENT_CITY_ID=C.CITY_ID;

