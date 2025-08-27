-- Active: 1756145054501@@127.0.0.1@5434@lesson6
CREATE DATABASE lesson6;

CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY, 
    first_name VARCHAR(50) NOT NULL, 
    last_name VARCHAR(50) NOT NULL, 
    email VARCHAR(100) NOT NULL UNIQUE, 
    password VARCHAR(255) NOT NULL, 
    role VARCHAR(20) NOT NULL CHECK (role IN ('student', 'teacher', 'admin')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP 
);

INSERT INTO Users (first_name, last_name, email, password, role, created_at) VALUES
('Ali', 'Valiyev', 'ali.valiyev@example.com', 'hashed_password_123', 'student', '2025-08-27 14:00:00+05'),
('Sardor', 'Qodirov', 'sardor.qodirov@example.com', 'hashed_password_456', 'teacher', '2025-08-27 14:01:00+05'),
('Nodira', 'Abdullayeva', 'nodira.abdullayeva@example.com', 'hashed_password_789', 'student', '2025-08-27 14:02:00+05'),
('Jasur', 'Toshmatov', 'jasur.toshmatov@example.com', 'hashed_password_101', 'admin', '2025-08-27 14:03:00+05');

SELECT * FROM users;


CREATE TABLE Courses (
    course_id SERIAL PRIMARY KEY, 
    title VARCHAR(100) NOT NULL, 
    description TEXT,
    teacher_id INTEGER, 
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (teacher_id) REFERENCES Users(user_id) ON DELETE SET NULL
);

INSERT INTO Courses (title, description, teacher_id, created_at) VALUES
('Python dasturlash', 'Python dasturlash tilini o‘rganish uchun boshlang‘ich kurs', 2, '2025-08-27 14:10:00+05'),
('Web dasturlash', 'HTML, CSS va JavaScript yordamida veb-saytlar yaratish', 2, '2025-08-27 14:11:00+05');
SELECT * FROM Courses;

CREATE TABLE Modules (
    module_id SERIAL PRIMARY KEY, 
    course_id INTEGER, 
    title VARCHAR(100) NOT NULL, 
    content TEXT, 
    order_number INTEGER NOT NULL, 
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);

INSERT INTO Modules (course_id, title, content, order_number) VALUES
(1, 'Python bilan tanishuv', 'Python haqida umumiy ma’lumot va o‘rnatish', 1),
(1, 'O‘zgaruvchilar va ma’lumot turlari', 'O‘zgaruvchilar, sonlar, matnlar', 2),
(2, 'HTML asoslari', 'HTML teglari va tuzilishi', 1),
(2, 'CSS bilan ishlash', 'CSS stillarini qo‘llash', 2);
SELECT * FROM Modules;

CREATE TABLE Assignments (
    assignment_id SERIAL PRIMARY KEY, 
    module_id INTEGER, 
    title VARCHAR(100) NOT NULL, 
    description TEXT, 
    deadline TIMESTAMP WITH TIME ZONE, 
    FOREIGN KEY (module_id) REFERENCES Modules(module_id) ON DELETE CASCADE
);

INSERT INTO Assignments (module_id, title, description, deadline) VALUES
(1, 'Python o‘rnatish', 'Python 3.10 ni kompyuteringizga o‘rnating va “Hello, World” dasturini yozing', '2025-09-10 23:59:00+05'),
(2, 'O‘zgaruvchilar bilan ishlash', '5 ta turli o‘zgaruvchi yaratib, ularni chop eting', '2025-09-15 23:59:00+05'),
(3, 'HTML sahifa yaratish', 'Oddiy HTML sahifasi yarating', '2025-09-12 23:59:00+05'),
(4, 'CSS dizayn', 'HTML sahifangizga CSS stillari qo‘shing', '2025-09-17 23:59:00+05');

SELECT * FROM Assignments;


CREATE TABLE Certificates (
    certificate_id SERIAL PRIMARY KEY,
    user_id INTEGER, 
    course_id INTEGER, 
    issue_date TIMESTAMP WITH TIME ZONE NOT NULL,
    certificate_url VARCHAR(255) UNIQUE, 
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);


INSERT INTO Certificates (user_id, course_id, issue_date, certificate_url) VALUES
(1, 1, '2025-08-27 15:00:00+05', 'http://example.com/certificates/python_ali_valiyev.pdf'),
(3, 2, '2025-08-27 15:01:00+05', 'http://example.com/certificates/web_nodira_abdullayeva.pdf');

SELECT * FROM Certificates;
