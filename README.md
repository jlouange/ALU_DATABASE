# ALU_DATABASE — School Database Project

A group MySQL project modelling a school: students, faculty, classrooms,
courses, extra-curricular activities, and the relationships between them.

## Running it

```bash
mysql -u root -p < school_database.sql
```

The script creates `alu_school_db`, drops existing tables for a clean reset,
then creates and populates each table in dependency order.

## Schema

| Table | Purpose |
|---|---|
| `Students` | Student records |
| `Faculty` | Teaching staff and departments |
| `Classroom` | Rooms available for courses |
| `Courses` | Courses, linked to faculty and classroom |
| `Extra_Curricular_Activities` | Clubs and activities |
| `Student_Courses` | Junction: students to courses (many-to-many) |
| `Student_Activities` | Junction: students to activities (many-to-many) |

## Contributions

Each member owns a section of `school_database.sql`, marked by comment headers:

- Member A — Students
- Member B — Classroom
- Member C — Faculty
- Member D — Courses
- Member E — Junction tables (`Student_Courses`, `Student_Activities`) and
  cross-schema JOIN queries

Each section includes the table definition, sample data, and
UPDATE / DELETE / SELECT statements.
