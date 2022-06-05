/* 3.1 metavlhtes */
SELECT DISTINCT
s.work_id , s.program_name 
	FROM WORKS s

		INNER JOIN EXECUTIVES b
		ON s.executive_ID= b.executive_ID
	WHERE b.name=' GREGORY'
	AND b.surname =' TRAKAS'
	AND s.commence_date = '04-06-2022'
	AND datediff(s.end_date,s.commence_date)= 15
	GROUP BY s.program_name 

SELECT DISTINCT
s.name , s.surname , s.researcher_ID
	FROM RESEARCHERS  s
		INNER JOIN RESEARCHERS_WORK b
		ON s.researcher_ID=b.researcher_ID
		INNER JOIN  WORKS a
		ON b.work_id=a.work_id
	WHERE (a.work_id=200)
ORDER BY s.researcher_ID

/* 3.2 ok */
CREATE VIEW Works_Researchers AS
SELECT DISTINCT  s.name,s.surname,s.date_of_birth,group_concat(a.work_id) 
	FROM RESEARCHERS  s
		INNER JOIN RESEARCHERS_WORK b
		ON s.researcher_ID=b.researcher_ID
		INNER JOIN  WORKS a
		ON b.work_id=a.work_id
		group by (s.researcher_id);
	
CREATE VIEW works_info AS
SELECT DISTINCT 
s.work_id, s.cost, s.commence_date, s.end_date, datediff(s.end_date,s.commence_date),s.program_name,
s.organization_name,s.summary text, GROUP_CONCAT(a.scientific_field), b.name as executive_name, b.surname as executive_surname, 
c.name as researcher_name ,c.surname as researcher_surname, 
d.evaluation_date,d.grade
	FROM WORKS s
		INNER JOIN FIELDS_OF_WORK fa
		ON s.work_id=fa.work_id 
		INNER JOIN  FIELDS a 
		ON fa.scientific_field=a.scientific_field
		INNER JOIN EXECUTIVES b
		ON s.executive_ID=b.executive_ID
		INNER JOIN RESEARCHERS c
		ON s.accountable_researcher_ID=c.researcher_ID
		INNER JOIN  EVALUATIONS d
		ON s.work_id=d.work_id
        group by s.work_id


/* 3.3   metablhth */
SELECT  b.name, b.surname, b.researcher_ID, f.work_id 
	FROM WORKS f
		INNER JOIN FIELDS_OF_WORK fa
		ON f.work_id=fa.work_id 
		INNER JOIN  FIELDS a 
		ON fa.scientific_field=a.scientific_field
		INNER JOIN RESEARCHERS_WORK fb 
		ON f.work_id= fb.work_id 
		INNER JOIN RESEARCHERS  b 
		ON fb.researcher_ID=b.researcher_ID
	WHERE (a.scientific_field= 'metavlhth' AND (f.end_date > (current_date()-1)))
    order by f.work_id;
	
/* 3.4 */

CREATE TABLE IF NOT EXISTS cust AS
(SELECT s.organization_name AS name  , extract(YEAR FROM f.commence_date) AS  st_date, count(*) as ammount	
		FROM ORGANIZATIONS s
			INNER JOIN WORKS f 
			ON s.organization_name=f.organization_name
	GROUP BY s.organization_name, st_date	
	HAVING ammount>9) ;
    
SELECT DISTINCT cust.name  FROM 
cust 
INNER JOIN cust a	
	ON ( (cust.name=a.name) AND (cust.st_date= (a.st_date+1) ) AND (cust.ammount=a.ammount)  )
GROUP BY cust.name ;

DROP TABLE CUST;
	
	
/* 3.5  dipla ta zeugaria */
SELECT DISTINCT f.scientific_field , fa.scientific_field, count(*) as num 
	FROM FIELDS_OF_WORK f
		CROSS JOIN FIELDS_OF_WORK fa
		ON (f.work_id=fa.work_id) AND (f.scientific_field != fa.scientific_field)
GROUP BY f.scientific_field, fa.scientific_field	
ORDER BY num DESC
limit 6;
	
/* 3.6  edw theloyme mono to max num_ofworks */
CREATE TABLE cust AS(
SELECT s.researcher_ID AS res_id , GROUP_CONCAT(a.work_id) AS wor_id, count(*) as num_ofworks 
	FROM RESEARCHERS s
		INNER JOIN RESEARCHERS_WORK a 
		ON s.researcher_ID=a.researcher_ID
		INNER JOIN WORKS b
		ON a.work_id= b.work_id
	WHERE ((  (DATEDIFF(current_date(),s.date_of_birth))<=14600) AND (b.end_date>current_date()))
GROUP BY s.researcher_ID	
order by num_ofworks DESC );


SELECT cust.res_id ,cust.wor_id , MAX(cust.num_ofworks) AS max_num FROM cust
WHERE cust.num_ofworks=(SELECT MAX(cust.num_ofworks) FROM cust);

DROP TABLE CUST;


/* 3.7 ok */
SELECT s.name, s.surname , a.organization_name, sum(b.cost) as totalcost /*select distinct ????? */
	FROM EXECUTIVES s
		INNER JOIN WORKS b 
		ON s.executive_ID=b.executive_ID
		INNER JOIN  ORGANIZATIONS  a 
		ON b.organization_name=a.organization_name
		INNER JOIN COMPANY d
		ON a.organization_name=d.organization_name
GROUP BY s.name,s.surname, a.organization_name
ORDER BY totalcost DESC
limit 5;
	
	
/* 3.8 ok */
SELECT s.researcher_Id,s.name , s.surname , count(*) as num_ofwork
	FROM RESEARCHERS s
		INNER JOIN RESEARCHERS_WORK a 
		ON s.researcher_ID=a.researcher_ID
		INNER JOIN WORKS b
		ON a.work_id= b.work_id
		LEFT JOIN DELIVERABLES  c 
		ON b.work_id = c.work_id
	WHERE  (c.work_id IS NULL)  
GROUP BY s.researcher_id
HAVING (num_ofwork>4) ;