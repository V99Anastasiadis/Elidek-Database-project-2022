CREATE  INDEX IX_organization_name_WORKS
ON WORKS (organization_name);

CREATE INDEX IX_executive_ID_WORKS
ON WORKS (executive_ID);

CREATE INDEX ΙΧ_workID_DELIVERABLES
ON DELIVERABLES (work_ID,start_date);

CREATE INDEX IX_commence_date_WORKS
ON WORKS (commence_date);

CREATE INDEX IX_end_date_WORKS
ON WORKS (end_date);

CREATE INDEX ΙΧ_workID_FIELDS_OF_WORKS
ON FIELDS_OF_WORK (work_id);

CREATE INDEX ΙΧ_scientific_field_FIELDS_OF_WORKS
ON FIELDS_OF_WORK (scientific_field);

CREATE INDEX ΙΧ_fullname_EXECUTIVES
ON EXECUTIVES (name,surname);

CREATE INDEX IX_fullname_RESEARCHERS
ON RESEARCHERS (name,surname);

CREATE INDEX IX_workID_RESEARCHERS_WORK
ON RESEARCHERS_WORK (work_id);

CREATE INDEX IX_researcher_ID_RESEARCHERS_WORK
ON RESEARCHERS_WORK (researcher_ID);

CREATE INDEX IX_organization_name_COMPANY
ON ORGANIZATIONS (organization_name);

CREATE  INDEX IX_ workID_EVALUATIONS 
ON EVALUATIONS  (work_ID);

CREATE  INDEX IX_researcher_ID _EVALUATIONS 
ON EVALUATIONS  (researcher_ID );
