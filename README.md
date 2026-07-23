# ALU Database: Play with SQL Basics (Peer Group Engagement Activity)

## Overview
A relational database for a school system built in MySQL, covering five entities: **Students, Classroom, Faculty, Courses,** and **Extra_Curricular_Activities**, connected through two junction tables (`Student_Courses`, `Student_Activities`) to handle the many-to-many relationships between students and courses, and students and activities.

All SQL lives in a single shared file: `school_database.sql`. Running it top to bottom on a fresh MySQL instance creates the database, all tables, sample data, individual member tasks, and the four group tasks in order.

## Running it

```bash
mysql -u root -p < school_database.sql
```

## Team Roster

| Name | GitHub Handle | Table / Section Owned |
|---|---|---|
| Jean Louange Mushumba| jlouange | Classroom table (Member B) |
| Gatete Irene Hodali | Hodali / Gatete Irene | Students table (Member A) |
| Musaedi Mbogo Isaac | Isa1ac309 | Faculty table (Member C), Verification support |
| Favour Ndelle Kebei | fave058 | Courses  table (Member D) |
| David Lael Nziza | davidlael | Extra_Curricular_Activities (Member E) |
| Anaise Umugwaneza| u-anaise | Student_Courses & Student_Activities junction tables, Group Tasks 1–4 |


*Note: Faculty's SQL was originally committed as part of initial project setup rather than under Isaac's own handle. A follow-up commit attributing and verifying that section under his handle has been added to correct this.*

## Build Order
Tables are created in dependency order, since foreign keys require the referenced table to exist first:
1. Classroom, Faculty (no dependencies)
2. Students, Courses (depend on Classroom/Faculty)
3. Extra_Curricular_Activities (depends on Faculty)
4. Student_Courses, Student_Activities (depend on everything above)

## File Structure (`school_database.sql`)
1. `CREATE DATABASE` and reset (`DROP TABLE IF EXISTS` guards for re-runnability)
2. All 5 `CREATE TABLE` statements, in dependency order, with PK/FK constraints
3. All `INSERT` statements (minimum 5 rows per table)
4. Individual `UPDATE` / `DELETE` / `SELECT` statements, labeled by member
5. Group Task 1: Relationship checks: `LEFT JOIN ... WHERE ... IS NULL` queries confirming no orphaned foreign keys across every relationship
6. Group Task 2: Normalization check (written as a comment block)
7. Group Task 3: Three `JOIN` queries pulling data across multiple tables
8. Group Task 4: Aggregate query (`COUNT` + `GROUP BY`) showing students enrolled per course

## Notes
- Deletes were checked to be foreign-key safe: no row is removed while another table still references it.
- Each section includes the table definition, sample data, and
UPDATE / DELETE / SELECT statements.
- Line endings have been normalized to avoid cross-platform diff noise.