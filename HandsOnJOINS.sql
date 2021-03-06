SELECT *
  FROM CHICAGO_CRIME_DATA;

SELECT *
  FROM CHICAGO_SOCIOECONOMIC_DATA;

SELECT *
  FROM CHICAGO_PUBLIC_SCHOOLS;


SELECT CCD.CASE_NUMBER, CCD.PRIMARY_TYPE, CSD.COMMUNITY_AREA_NAME
  FROM CHICAGO_CRIME_DATA CCD 
INNER JOIN CHICAGO_SOCIOECONOMIC_DATA CSD 
ON CCD.COMMUNITY_AREA_NUMBER = CSD.CA
  WHERE CCD.COMMUNITY_AREA_NUMBER = 18;




SELECT CCD.CASE_NUMBER, CCD.PRIMARY_TYPE, CSD.COMMUNITY_AREA_NAME
  FROM CHICAGO_CRIME_DATA CCD 
LEFT OUTER JOIN CHICAGO_SOCIOECONOMIC_DATA CSD 
ON CCD.COMMUNITY_AREA_NUMBER = CSD.CA
  WHERE CCD.LOCATION_DESCRIPTION LIKE '%SCHOOL%';




SELECT CCD.CASE_NUMBER, CCD.COMMUNITY_AREA_NUMBER, CSD.COMMUNITY_AREA_NAME
  FROM CHICAGO_CRIME_DATA CCD 
FULL OUTER JOIN CHICAGO_SOCIOECONOMIC_DATA CSD 
ON CCD.COMMUNITY_AREA_NUMBER = CSD.CA
  WHERE CSD.COMMUNITY_AREA_NAME 
IN ('Oakland', 'Armour Square', 'Edgewater','CHICAGO');