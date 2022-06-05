create database IF NOT EXISTS works_project;
use works_project;
SET FOREIGN_KEY_CHECKS=0;
create table IF NOT EXISTS WORKS
	(work_id int not null AUTO_INCREMENT,
	title varchar(100) not null,
	cost int not null, 
	commence_date date not null, 
	end_date date not null, 
	duration int not null,
	summary text,
	program_name varchar(50) not null,
	accountable_researcher_ID int not null,
	executive_ID int not null,
	organization_name varchar(50) not null ,
	primary key (work_id),
    foreign key (program_name) REFERENCES ELIDEK_PROGRAMS(program_name) ON UPDATE CASCADE ON DELETE RESTRICT ,
	foreign key (organization_name) REFERENCES ORGANIZATION(organization_name) ON UPDATE CASCADE ON DELETE RESTRICT , 
	foreign key (accountable_researcher_ID) REFERENCES RESEARCHERS(researcher_ID) ON UPDATE CASCADE ON DELETE RESTRICT,
	foreign key (executive_ID) REFERENCES EXECUTIVES(executive_ID) ON UPDATE CASCADE ON DELETE RESTRICT
);	

create table IF NOT EXISTS DELIVERABLES
	(deliverable_ID int not null AUTO_INCREMENT,
    deliverable_title varchar(100) not null,
    summary text not null,
    work_id int not null ,
    delivery_date date not null,
    start_date date not null,
    ending_date date not null,
    primary key (deliverable_ID),
	foreign key (work_id) REFERENCES WORKS(work_id) ON UPDATE CASCADE ON DELETE CASCADE ,
    FOREIGN KEY (start_date, ending_date)
      REFERENCES product(commence_date,end_date)
      ON UPDATE CASCADE ON DELETE RESTRICT
);

create table IF NOT EXISTS FIELDS /*episthmonika pedia*/
	(scientific_field varchar(50) not null,
	primary key (scientific_field)
);

create table IF NOT EXISTS FIELDS_OF_WORK/*TA ERGA SE EPISTIMONIKA PEDIA*/
	(work_id int,
	scientific_field varchar(50),
	CONSTRAINT ids foreign key (work_id) REFERENCES WORKS(work_id) ON UPDATE CASCADE ON DELETE SET NULL ,
	CONSTRAINT sci_field foreign key (scientific_field) REFERENCES FIELDS(scientific_field) ON UPDATE CASCADE ON DELETE RESTRICT ,
	CONSTRAINT field_unique UNIQUE (work_id,scientific_field)
);

create table IF NOT EXISTS EXECUTIVES /* stelexh */
	(executive_ID int,
	gender varchar(10) not null,
	date_of_birth date not null,
	name varchar(25) not null,
	surname varchar(25) not null,
	intendancy_name varchar(50), 
	primary key (executive_ID),
	foreign key (intendancy_name) REFERENCES ELIDEK_INTENDANCY (intendancy_name) ON UPDATE CASCADE ON DELETE RESTRICT
);

create table IF NOT EXISTS ELIDEK_INTENDANCY
	(intendancy_name varchar(50),
	primary key (intendancy_name)
);

create table IF NOT EXISTS ELIDEK_PROGRAMS
	(program_name varchar(50),
	intendancy_name varchar(50),
	primary key (program_name),
	foreign key (intendancy_name) REFERENCES ELIDEK_INTENDANCY (intendancy_name) ON UPDATE CASCADE ON DELETE RESTRICT
);

create table IF NOT EXISTS RESEARCHERS 
	(researcher_ID int,
	gender varchar(10) not null,
	name varchar(25) not null,
	surname varchar(25) not null,
	date_of_birth date not null,
	date_commencement_organization date not null,
	organization_name varchar(50) not null,
	primary key (researcher_ID),
	foreign key (organization_name) REFERENCES ORGANIZATIONS(organization_name) ON UPDATE CASCADE ON DELETE RESTRICT 
);

create table IF NOT EXISTS RESEARCHERS_WORK
	(work_id int,
	researcher_ID int,
	CONSTRAINT researchers_in_work foreign key (work_id) REFERENCES WORKS(work_id) ON UPDATE CASCADE ON DELETE  CASCADE ,
	CONSTRAINT works_of_researcher foreign key (researcher_ID) REFERENCES RESEARCHERS(researcher_ID) ON UPDATE CASCADE ON DELETE SET NULL ,
	CONSTRAINT unique_works UNIQUE (work_id,researcher_ID)
);

create table IF NOT EXISTS EVALUATIONS 
	(evaluation_ID int,
	work_id int not null,
	researcher_ID int not null, 
	grade int not null, 
 	evaluation_date date not null,
	start_date date not null,
	primary key (evaluation_ID),
	foreign key (work_id) REFERENCES WORKS(work_id) ON UPDATE CASCADE ON DELETE  CASCADE  ,
	foreign key (researcher_ID) REFERENCES RESEARCHERS(researcher_ID) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (start_date)
      REFERENCES product(commence_date)
      ON UPDATE CASCADE ON DELETE RESTRICT
);

create table IF NOT EXISTS ORGANIZATIONS 
	(organization_name varchar(50),
	abbreviation varchar(5) UNIQUE, /*syntomografia*/
	category varchar(20) not null, /* strictly UNIVERSITY,COMPANY,RESEARCH_CENTER 1 apo ta 3  */
	street varchar(30),
	city varchar(30),
	street_number varchar(5),
	postal_code int(5) unsigned,
	primary key (organization_name)
);

create table IF NOT EXISTS TELEPHONES
	(phone int,
	organization_name varchar(50),
	primary key (phone),
	foreign key (organization_name) REFERENCES ORGANIZATIONS (organization_name) ON UPDATE CASCADE ON DELETE  CASCADE  	
);

create table IF NOT EXISTS RESEARCH_CENTER 
	(center_name varchar(50),
	private_sector_budget int DEFAULT 0,
	education_ministry_subsidy int DEFAULT 0, 
	organization_name varchar(50),
	primary key (center_name),
	foreign key (organization_name) REFERENCES ORGANIZATIONS (organization_name) ON UPDATE CASCADE ON DELETE  CASCADE 
);

create table IF NOT EXISTS UNIVERSITY
	(university_name varchar(50),
	education_ministry_subsidy int DEFAULT 0, 
	organization_name varchar(50),
	primary key (university_name),
	foreign key (organization_name) REFERENCES ORGANIZATIONS (organization_name) ON UPDATE CASCADE ON DELETE  CASCADE 
);

create table IF NOT EXISTS COMPANY 
	(company_name varchar(50),
	company_budget int DEFAULT 0, /*arxikopoihsh 0*/
	organization_name varchar(50),
	primary key (company_name),
	foreign key (organization_name) REFERENCES ORGANIZATIONS (organization_name) ON UPDATE CASCADE ON DELETE  CASCADE 
);

SET FOREIGN_KEY_CHECKS=1;