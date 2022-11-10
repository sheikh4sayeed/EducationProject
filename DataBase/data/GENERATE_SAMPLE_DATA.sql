---- USER ---- 
DELETE FROM Notifications;
DELETE FROM Notices;
DELETE FROM EnrolledIn;
DELETE FROM Batches;
DELETE FROM Courses;
DELETE FROM MemberOf;
DELETE FROM Coachings;
DELETE FROM Offers;
DELETE FROM Applies;
DELETE FROM Tution_Posts;
DELETE FROM Tutions;
DELETE FROM Educations;
DELETE FROM Tutors;
DELETE FROM Students;
DELETE FROM Users;
INSERT INTO Users(name,image,email,pass,role,gender,phone_number,date_of_birth)
VALUES('Mahir Labib Dihan','student1.jpg','mahirlabibdihan@gmail.com','$2a$10$8GBsWOPaNtD5gUZu1bNB7uCh0mk3Y6NY25SnGTr1mbuWwKsFPYY5G','STUDENT','Male','01851953433',to_date('19-AUG-01','DD-MON-RR'));
INSERT INTO Users(name,image,email,pass,role,gender,phone_number,date_of_birth)
VALUES ('Abdullah Al Mamun','student3.jpg','vonda@gmail.com','$2a$10$t7tfxUp7R/loxmxKcuAbY.sObMjcHiwrps/mTpq0/1jJqlfj9BCl2','STUDENT','Male','01421945693',to_date('25-DEC-00','DD-MON-RR'));
INSERT INTO Users(name,image,email,pass,role,gender,phone_number,date_of_birth)
VALUES ('Muntasir Mamun Nahid','student2.jpg','takla@gmail.com','$2a$10$cNR392ChvTW9rJ4BUY8fDep68xgk7MlJ0pgB.HIAkA/E69HKSSeM2','STUDENT','Male','01684828706',to_date('27-AUG-01','DD-MON-RR'));

INSERT INTO Users(name,image,email,pass,role,gender,phone_number,date_of_birth)
VALUES('Mahir Tazwar Ohi','tutor1.jpg','mahirtazwarohi@gmail.com','$2a$10$8GBsWOPaNtD5gUZu1bNB7uCh0mk3Y6NY25SnGTr1mbuWwKsFPYY5G','TUTOR','Male','01767493500',to_date('03-DEC-00','DD-MON-RR'));
INSERT INTO Users(name,image,email,pass,role,gender,phone_number,date_of_birth)
VALUES('Md Sharif Uddin','tutor2.jpg','sharif@gmail.com','$2a$10$8GBsWOPaNtD5gUZu1bNB7uCh0mk3Y6NY25SnGTr1mbuWwKsFPYY5G','TUTOR','Male','01867549950',to_date('03-MAR-00','DD-MON-RR'));
INSERT INTO Users(name,image,email,pass,role,gender,phone_number,date_of_birth)
VALUES ('Sadat Hossain','tutor5.jpg','1905001@gmail.com','$2a$10$GgiK3IOV9GluNyOnl.P0xO/jnfIudswCvwdKLFm0SKd39sHi4Misq','TUTOR','Male','01891578643',to_date('01-JAN-00','DD-MON-RR'));
INSERT INTO Users(name,image,email,pass,role,gender,phone_number,date_of_birth)
VALUES ('Nafis Tahmid','tutor12.jpg','1905002@gmail.com','$2a$10$GgiK3IOV9GluNyOnl.P0xO/jnfIudswCvwdKLFm0SKd39sHi4Misq','TUTOR','Male','01478066006',to_date('01-JAN-00','DD-MON-RR'));
INSERT INTO Users(name,image,email,pass,role,gender,phone_number,date_of_birth)
VALUES ('Asif Azad','tutor9.jpg','1905004@gmail.com','$2a$10$GgiK3IOV9GluNyOnl.P0xO/jnfIudswCvwdKLFm0SKd39sHi4Misq','TUTOR','Male','01891556749',to_date('01-JAN-00','DD-MON-RR'));
INSERT INTO Users(name,image,email,pass,role,gender,phone_number,date_of_birth)
VALUES ('Md. Ashrafur Rahman','tutor14.jpg','1905005@gmail.com','$2a$10$GgiK3IOV9GluNyOnl.P0xO/jnfIudswCvwdKLFm0SKd39sHi4Misq','TUTOR','Male','01478066006',to_date('01-JAN-00','DD-MON-RR'));
INSERT INTO Users(name,image,email,pass,role,gender,phone_number,date_of_birth)
VALUES ('Shattik Islam Rhythm','tutor11.jpg','1905008@gmail.com','$2a$10$GgiK3IOV9GluNyOnl.P0xO/jnfIudswCvwdKLFm0SKd39sHi4Misq','TUTOR','Male','01881536649',to_date('01-JAN-00','DD-MON-RR'));
INSERT INTO Users(name,image,email,pass,role,gender,phone_number,date_of_birth)
VALUES ('Md. Ishrak Ahsan','tutor21.jpg','1905045@gmail.com','$2a$10$GgiK3IOV9GluNyOnl.P0xO/jnfIudswCvwdKLFm0SKd39sHi4Misq','TUTOR','Male','01478066006',to_date('01-JAN-00','DD-MON-RR'));

INSERT INTO Users(name,image,email,pass,role,gender,phone_number,date_of_birth)
VALUES('Farhan Mahmud','student4.jpg','betu@gmail.com','$2a$10$8GBsWOPaNtD5gUZu1bNB7uCh0mk3Y6NY25SnGTr1mbuWwKsFPYY5G','STUDENT','Male','01851953433',to_date('19-AUG-01','DD-MON-RR'));
INSERT INTO Users(name,image,email,pass,role,gender,phone_number,date_of_birth)
VALUES ('Nayem Mahmud','student5.jpg','boga@gmail.com','$2a$10$t7tfxUp7R/loxmxKcuAbY.sObMjcHiwrps/mTpq0/1jJqlfj9BCl2','STUDENT','Male','01421945693',to_date('25-DEC-00','DD-MON-RR'));
INSERT INTO Users(name,image,email,pass,role,gender,phone_number,date_of_birth)
VALUES ('Ibrahim Shagor','student6.jpg','mokhles@gmail.com','$2a$10$cNR392ChvTW9rJ4BUY8fDep68xgk7MlJ0pgB.HIAkA/E69HKSSeM2','STUDENT','Male','01684828706',to_date('27-AUG-01','DD-MON-RR'));

INSERT INTO Users(name,image,email,pass,role,gender,phone_number,date_of_birth)
VALUES ('Nazmus Sakib','tutor17.jpg','1905061@gmail.com','$2a$10$GgiK3IOV9GluNyOnl.P0xO/jnfIudswCvwdKLFm0SKd39sHi4Misq','TUTOR','Male','01478066006',to_date('01-JAN-00','DD-MON-RR'));
INSERT INTO Users(name,image,email,pass,role,gender,phone_number,date_of_birth)
VALUES ('Sayem Shahad Soummo','tutor8.jpg','1905064@gmail.com','$2a$10$GgiK3IOV9GluNyOnl.P0xO/jnfIudswCvwdKLFm0SKd39sHi4Misq','TUTOR','Male','01741656919',to_date('01-JAN-00','DD-MON-RR'));
INSERT INTO Users(name,image,email,pass,role,gender,phone_number,date_of_birth)
VALUES ('Prottoy Barai','tutor13.jpg','1905068@gmail.com','$2a$10$GgiK3IOV9GluNyOnl.P0xO/jnfIudswCvwdKLFm0SKd39sHi4Misq','TUTOR','Male','01478066006',to_date('01-JAN-00','DD-MON-RR'));
INSERT INTO Users(name,image,email,pass,role,gender,phone_number,date_of_birth)
VALUES ('Mashroor Hasan Bhuiyan','tutor10.jpg','1905069@gmail.com','$2a$10$GgiK3IOV9GluNyOnl.P0xO/jnfIudswCvwdKLFm0SKd39sHi4Misq','TUTOR','Male','01478066006',to_date('01-JAN-00','DD-MON-RR'));
INSERT INTO Users(name,image,email,pass,role,gender,phone_number,date_of_birth)
VALUES ('Anindya Hoque','tutor6.jpg','1905070@gmail.com','$2a$10$GgiK3IOV9GluNyOnl.P0xO/jnfIudswCvwdKLFm0SKd39sHi4Misq','TUTOR','Male','01478066006',to_date('01-JAN-00','DD-MON-RR'));
INSERT INTO Users(name,image,email,pass,role,gender,phone_number,date_of_birth)
VALUES ('Tareq Ahmed','tutor3.jpg','1905071@gmail.com','$2a$10$GgiK3IOV9GluNyOnl.P0xO/jnfIudswCvwdKLFm0SKd39sHi4Misq','TUTOR','Male','01478066006',to_date('01-JAN-00','DD-MON-RR'));
INSERT INTO Users(name,image,email,pass,role,gender,phone_number,date_of_birth)
VALUES ('Souvik Ghosh','tutor4.jpg','1905073@gmail.com','$2a$10$GgiK3IOV9GluNyOnl.P0xO/jnfIudswCvwdKLFm0SKd39sHi4Misq','TUTOR','Male','01911714385',to_date('01-JAN-00','DD-MON-RR'));
INSERT INTO Users(name,image,email,pass,role,gender,phone_number,date_of_birth)
VALUES ('Tahmid Islam Tomal','tutor16.jpg','1905074@gmail.com','$2a$10$GgiK3IOV9GluNyOnl.P0xO/jnfIudswCvwdKLFm0SKd39sHi4Misq','TUTOR','Male','01478066006',to_date('01-JAN-00','DD-MON-RR'));
INSERT INTO Users(name,image,email,pass,role,gender,phone_number,date_of_birth)
VALUES ('Md. Shafiul Haque','tutor20.jpg','1905102@gmail.com','$2a$10$GgiK3IOV9GluNyOnl.P0xO/jnfIudswCvwdKLFm0SKd39sHi4Misq','TUTOR','Male','01478066006',to_date('01-JAN-00','DD-MON-RR'));
INSERT INTO Users(name,image,email,pass,role,gender,phone_number,date_of_birth)
VALUES ('Rayan Islam','tutor18.jpg','1905106@gmail.com','$2a$10$GgiK3IOV9GluNyOnl.P0xO/jnfIudswCvwdKLFm0SKd39sHi4Misq','TUTOR','Male','01478066006',to_date('01-JAN-00','DD-MON-RR'));
INSERT INTO Users(name,image,email,pass,role,gender,phone_number,date_of_birth)
VALUES ('Saad Mohammad Rafid','tutor15.jpg','1905112@gmail.com','$2a$10$GgiK3IOV9GluNyOnl.P0xO/jnfIudswCvwdKLFm0SKd39sHi4Misq','TUTOR','Male','01478066006',to_date('01-JAN-00','DD-MON-RR'));
INSERT INTO Users(name,image,email,pass,role,gender,phone_number,date_of_birth)
VALUES ('Tahsin Wahid','tutor19.jpg','1905115@gmail.com','$2a$10$GgiK3IOV9GluNyOnl.P0xO/jnfIudswCvwdKLFm0SKd39sHi4Misq','TUTOR','Male','01478066006',to_date('01-JAN-00','DD-MON-RR'));

INSERT INTO Users(name,image,email,pass,role,gender,phone_number,date_of_birth)
VALUES ('Md. Jarif Ahsan','male_student.jpg','1905092@gmail.com','$2a$10$GgiK3IOV9GluNyOnl.P0xO/jnfIudswCvwdKLFm0SKd39sHi4Misq','STUDENT','Male','01478066006',to_date('01-JAN-00','DD-MON-RR'));
INSERT INTO Users(name,image,email,pass,role,gender,phone_number,date_of_birth)
VALUES ('Lara Khanom','female_student.jpg','1905062@gmail.com','$2a$10$GgiK3IOV9GluNyOnl.P0xO/jnfIudswCvwdKLFm0SKd39sHi4Misq','STUDENT','Female','01478066006',to_date('01-JAN-00','DD-MON-RR'));
INSERT INTO Users(name,image,email,pass,role,gender,phone_number,date_of_birth)
VALUES ('Md. Labid Al Nahiyan','male_student.jpg','1905110@gmail.com','$2a$10$GgiK3IOV9GluNyOnl.P0xO/jnfIudswCvwdKLFm0SKd39sHi4Misq','STUDENT','Male','01478066006',to_date('01-JAN-00','DD-MON-RR'));
INSERT INTO Users(name,image,email,pass,role,gender,phone_number,date_of_birth)
VALUES ('Kazi Istiak Uddin Torique','male_student.jpg','1905104@gmail.com','$2a$10$GgiK3IOV9GluNyOnl.P0xO/jnfIudswCvwdKLFm0SKd39sHi4Misq','STUDENT','Male','01478066006',to_date('01-JAN-00','DD-MON-RR'));

----STUDENT----
DELETE FROM Students;
INSERT INTO Students (user_id,institution,version,class,address) 
VALUES (1,'NDC','Bangla Medium','Class 12','38/1, Indira Road, Farmgate, Dhaka');
INSERT INTO Students (user_id,institution,version,class,address) 
VALUES (2,'DMRC','Bangla Medium','Class 12','Narayanganj');
INSERT INTO Students (user_id,institution,version,class,address) 
VALUES (3,'NDC','Bangla Medium','Class 12','Banasree, Dhaka');INSERT INTO Students (user_id,institution,version,class,address) 
VALUES (12,'CVC','Bangla Medium','Class 12','Mahmud Mansion, Cumilla');
INSERT INTO Students (user_id,institution,version,class,address) 
VALUES (13,'CGC','Bangla Medium','Class 12','Bogalake, Bandarban');
INSERT INTO Students (user_id,institution,version,class,address) 
VALUES (14,'CVC','Bangla Medium','Class 12','Cumilla');
INSERT INTO Students (user_id,institution,version,class,address) 
VALUES (27,'NDC','Bangla Medium','Class 12','Narayanganj');
INSERT INTO Students (user_id,institution,version,class,address) 
VALUES (28,'Vidyamayee','Bangla Medium','Class 10','Mymensingh');
INSERT INTO Students (user_id,institution,version,class,address) 
VALUES (29,'NDC','Bangla Medium','Class 12','Mahmud Mansion, Cumilla');
INSERT INTO Students (user_id,institution,version,class,address) 
VALUES (30,'NDC','Bangla Medium','Class 12','Bogalake, Bandarban');

----TUTOR----
DELETE FROM Tutors;
INSERT INTO Tutors (user_id,expertise,availability,years_of_experience,preffered_salary) 
VALUES (4,'Math, Physics, Chemistry, Higher Math','Available',4,12000);
INSERT INTO Tutors (user_id,expertise,availability,years_of_experience,preffered_salary) 
VALUES (5,'Math, Physics, Chemistry, ICT','Available',2,1000);
INSERT INTO Tutors (user_id,expertise,availability,years_of_experience,preffered_salary) 
VALUES (6,'Math, Physics, Chemistry, ICT, English','Available',4,10000);
INSERT INTO Tutors (user_id,expertise,availability,years_of_experience,preffered_salary) 
VALUES (7,'Physics','Available',3,10000);
INSERT INTO Tutors (user_id,expertise,availability,years_of_experience,preffered_salary) 
VALUES (8,'Math, Physics, Chemistry','Unavailable',3,10000);
INSERT INTO Tutors (user_id,expertise,availability,years_of_experience,preffered_salary) 
VALUES (9,'English','Available',3,10000);
INSERT INTO Tutors (user_id,expertise,availability,years_of_experience,preffered_salary) 
VALUES (10,'Math','Available',3,10000);
INSERT INTO Tutors (user_id,expertise,availability,years_of_experience,preffered_salary) 
VALUES (11,'Math, Physics, Chemistry','Available',3,10000);
INSERT INTO Tutors (user_id,expertise,availability,years_of_experience,preffered_salary) 
VALUES (15,'Math, Physics, Chemistry','Available',3,10000);
INSERT INTO Tutors (user_id,expertise,availability,years_of_experience,preffered_salary) 
VALUES (16,'Math, Physics, Chemistry','Available',3,10000);
INSERT INTO Tutors (user_id,expertise,availability,years_of_experience,preffered_salary) 
VALUES (17,'Math, Physics, Chemistry','Available',3,10000);
INSERT INTO Tutors (user_id,expertise,availability,years_of_experience,preffered_salary) 
VALUES (18,'Math, Physics, Chemistry','Available',3,10000);
INSERT INTO Tutors (user_id,expertise,availability,years_of_experience,preffered_salary) 
VALUES (19,'Math, Physics, Chemistry','Available',3,10000);
INSERT INTO Tutors (user_id,expertise,availability,years_of_experience,preffered_salary) 
VALUES (20,'Math, Physics, Chemistry','Available',3,10000);
INSERT INTO Tutors (user_id,expertise,availability,years_of_experience,preffered_salary) 
VALUES (21,'Math, Physics, Chemistry','Available',3,10000);
INSERT INTO Tutors (user_id,expertise,availability,years_of_experience,preffered_salary) 
VALUES (22,'Math, Physics, Chemistry','Available',3,10000);
INSERT INTO Tutors (user_id,expertise,availability,years_of_experience,preffered_salary) 
VALUES (23,'Math, Physics, Chemistry','Available',3,10000);
INSERT INTO Tutors (user_id,expertise,availability,years_of_experience,preffered_salary) 
VALUES (24,'Math, Physics, Chemistry','Available',3,10000);
INSERT INTO Tutors (user_id,expertise,availability,years_of_experience,preffered_salary) 
VALUES (25,'Math, Physics, Chemistry','Available',3,10000);
INSERT INTO Tutors (user_id,expertise,availability,years_of_experience,preffered_salary) 
VALUES (26,'Math, Physics, Chemistry','Available',3,10000);

---- TUTION ----
DELETE FROM Tutions;
INSERT INTO Tutions (subjects,salary,days_per_week,type,class_days,start_time,end_time,start_date) 
VALUES ('Math',10000,3,'Offline','Sun, Tue, Thu',to_date('13:00:00','HH24:MI:SS'),to_date('14:00:00','HH24:MI:SS'),to_date('21-AUG-22','DD-MON-RR'));
INSERT INTO Tutions (subjects,salary,days_per_week,type,class_days,start_time,end_time,start_date) 
VALUES ('Physics',5000,3,'Offline','Sat, Mon, Wed',to_date('14:00:00','HH24:MI:SS'),to_date('15:00:00','HH24:MI:SS'),to_date('20-AUG-22','DD-MON-RR'));
INSERT INTO Tutions (subjects,salary,days_per_week,type,class_days,start_time,end_time,start_date) 
VALUES ('Math',8000,3,'Offline','Sun, Tue, Thu',to_date('15:00:00','HH24:MI:SS'),to_date('16:00:00','HH24:MI:SS'),to_date('21-AUG-22','DD-MON-RR'));
INSERT INTO Tutions (subjects,salary,days_per_week,type,class_days,start_time,end_time,start_date)  
VALUES ('Math, Physics, Chemistry',10000,4,'Online','Sat, Mon, Wed',to_date('16:00:00','HH24:MI:SS'),to_date('17:00:00','HH24:MI:SS'),to_date('20-AUG-22','DD-MON-RR'));
INSERT INTO Tutions (subjects,salary,days_per_week,type,class_days,start_time,end_time,start_date) 
VALUES ('Chemistry, Higher Math',5000,4,'Offline','Sun, Tue, Thu',to_date('17:00:00','HH24:MI:SS'),to_date('18:00:00','HH24:MI:SS'),to_date('21-AUG-22','DD-MON-RR'));
INSERT INTO Tutions (subjects,salary,days_per_week,type,class_days,start_time,end_time,start_date) 
VALUES ('Math, Physics, Chemistry',10000,4,'Online','Sat, Mon, Wed',to_date('18:00:00','HH24:MI:SS'),to_date('19:00:00','HH24:MI:SS'),to_date('20-AUG-22','DD-MON-RR'));
INSERT INTO Tutions (subjects,salary,days_per_week,type,class_days,start_time,end_time,start_date)  
VALUES ('ICT',5000,3,'Online','Sun, Tue, Thu',to_date('19:00:00','HH24:MI:SS'),to_date('20:00:00','HH24:MI:SS'),to_date('21-AUG-22','DD-MON-RR'));
INSERT INTO Tutions (subjects,salary,days_per_week,type,class_days,start_time,end_time,start_date) 
VALUES ('Math, Physics, Chemistry',10000,3,'Online','Sat, Mon, Wed',to_date('20:00:00','HH24:MI:SS'),to_date('21:00:00','HH24:MI:SS'),to_date('20-AUG-22','DD-MON-RR'));
INSERT INTO Tutions (subjects,salary,days_per_week,type,class_days,start_time,end_time,start_date) 
VALUES ('Chemistry',8000,2,'Offline','Sun, Tue, Thu',to_date('21:00:00','HH24:MI:SS'),to_date('22:00:00','HH24:MI:SS'),to_date('21-AUG-22','DD-MON-RR'));
INSERT INTO Tutions (subjects,salary,days_per_week,type,class_days,start_time,end_time,start_date) 
VALUES ('Higher Math',5000,3,'Online','Sat, Mon, Wed',to_date('07:00:00','HH24:MI:SS'),to_date('08:00:00','HH24:MI:SS'),to_date('20-AUG-22','DD-MON-RR'));
INSERT INTO Tutions (subjects,salary,days_per_week,type,class_days,start_time,end_time,start_date) 
VALUES ('Math',10000,3,'Offline','Sun, Tue, Thu',to_date('08:00:00','HH24:MI:SS'),to_date('09:00:00','HH24:MI:SS'),to_date('21-AUG-22','DD-MON-RR'));
INSERT INTO Tutions (subjects,salary,days_per_week,type,class_days,start_time,end_time,start_date) 
VALUES ('Math',12000,7,'Online','Sat, Mon, Wed',to_date('09:00:00','HH24:MI:SS'),to_date('10:00:00','HH24:MI:SS'),to_date('20-AUG-22','DD-MON-RR'));

INSERT INTO Tutions (subjects,salary,days_per_week,type,class_days,start_time,end_time,start_date) 
VALUES ('Math, Physics, Chemistry',5000,5,'Offline','Sun, Tue, Thu',to_date('10:00:00','HH24:MI:SS'),to_date('11:00:00','HH24:MI:SS'),to_date('21-AUG-22','DD-MON-RR'));
INSERT INTO Tutions (subjects,salary,days_per_week,type,class_days,start_time,end_time,start_date) 
VALUES ('Chemistry',10000,3,'Offline','Sat, Mon, Wed',to_date('14:00:00','HH24:MI:SS'),to_date('15:00:00','HH24:MI:SS'),to_date('20-AUG-22','DD-MON-RR'));
INSERT INTO Tutions (subjects,salary,days_per_week,type,class_days,start_time,end_time,start_date) 
VALUES ('Math',12000,7,'Online','Sun, Tue, Thu',to_date('12:00:00','HH24:MI:SS'),to_date('13:00:00','HH24:MI:SS'),to_date('21-AUG-22','DD-MON-RR'));
INSERT INTO Tutions (subjects,salary,days_per_week,type,class_days,start_time,end_time,start_date) 
VALUES ('Physics',5000,5,'Offline','Sat, Mon, Wed',to_date('13:00:00','HH24:MI:SS'),to_date('14:00:00','HH24:MI:SS'),to_date('20-AUG-22','DD-MON-RR'));
INSERT INTO Tutions (subjects,salary,days_per_week,type,class_days,start_time,end_time,start_date) 
VALUES ('Chemistry',10000,3,'Offline','Sun, Tue, Thu',to_date('13:00:00','HH24:MI:SS'),to_date('14:00:00','HH24:MI:SS'),to_date('21-AUG-22','DD-MON-RR'));
INSERT INTO Tutions (subjects,salary,days_per_week,type,class_days,start_time,end_time,start_date) 
VALUES ('Physics',5000,3,'Offline','Sat, Mon, Wed',to_date('14:00:00','HH24:MI:SS'),to_date('15:00:00','HH24:MI:SS'),to_date('20-AUG-22','DD-MON-RR'));
INSERT INTO Tutions (subjects,salary,days_per_week,type,class_days,start_time,end_time,start_date) 
VALUES ('Chemistry',8000,3,'Offline','Thu, Fri, Sat',to_date('15:00:00','HH24:MI:SS'),to_date('16:00:00','HH24:MI:SS'),to_date('20-AUG-22','DD-MON-RR'));
INSERT INTO Tutions (subjects,salary,days_per_week,type,class_days,start_time,end_time,start_date)  
VALUES ('Math, Physics, Chemistry',10000,4,'Online','Sun, Tue, Thu',to_date('16:00:00','HH24:MI:SS'),to_date('17:00:00','HH24:MI:SS'),to_date('21-AUG-22','DD-MON-RR'));
INSERT INTO Tutions (subjects,salary,days_per_week,type,class_days,start_time,end_time,start_date) 
VALUES ('Math, Chemistry',5000,4,'Offline','Sat, Mon, Wed',to_date('17:00:00','HH24:MI:SS'),to_date('18:00:00','HH24:MI:SS'),to_date('20-AUG-22','DD-MON-RR'));

---- TUTION_POST ----
DELETE FROM Tution_Posts;
INSERT INTO Tution_Posts (student_id,tution_id,desired_tutor_gender,booking_status,selected_tutor) 
VALUES (1,1,'Male','BOOKED',6);
INSERT INTO Tution_Posts (student_id,tution_id,desired_tutor_gender) 
VALUES (1,2,'Female');
INSERT INTO Tution_Posts (student_id,tution_id,desired_tutor_gender) 
VALUES (2,3,'Male');
INSERT INTO Tution_Posts (student_id,tution_id,desired_tutor_gender) 
VALUES (2,4,'Male');
INSERT INTO Tution_Posts (student_id,tution_id,desired_tutor_gender) 
VALUES (3,5,'Male');
INSERT INTO Tution_Posts (student_id,tution_id,desired_tutor_gender) 
VALUES (3,6,'Male');
INSERT INTO Tution_Posts (student_id,tution_id,desired_tutor_gender) 
VALUES (12,7,'Female');
INSERT INTO Tution_Posts (student_id,tution_id,desired_tutor_gender) 
VALUES (12,8,'Male');
INSERT INTO Tution_Posts (student_id,tution_id,desired_tutor_gender) 
VALUES (13,9,'Male');
INSERT INTO Tution_Posts (student_id,tution_id,desired_tutor_gender) 
VALUES (13,10,'Male');
INSERT INTO Tution_Posts (student_id,tution_id,desired_tutor_gender) 
VALUES (14,11,'Male');
INSERT INTO Tution_Posts (student_id,tution_id,desired_tutor_gender) 
VALUES (14,12,'Female');

---- APPLY ----
DELETE FROM Applies;
INSERT INTO Applies (tutor_id,POST_ID) 
VALUES (4,1);
INSERT INTO Applies (tutor_id,POST_ID) 
VALUES (7,1);
INSERT INTO Applies (tutor_id,POST_ID) 
VALUES (6,1);
INSERT INTO Applies (tutor_id,POST_ID) 
VALUES (8,1);
INSERT INTO Applies (tutor_id,POST_ID) 
VALUES (9,1);
INSERT INTO Applies (tutor_id,POST_ID) 
VALUES (10,1);

INSERT INTO Applies (tutor_id,POST_ID) 
VALUES (4,2);
INSERT INTO Applies (tutor_id,POST_ID) 
VALUES (15,2);
INSERT INTO Applies (tutor_id,POST_ID) 
VALUES (16,2);
INSERT INTO Applies (tutor_id,POST_ID) 
VALUES (17,2);
INSERT INTO Applies (tutor_id,POST_ID) 
VALUES (18,2);

INSERT INTO Applies (tutor_id,POST_ID) 
VALUES (4,3);
INSERT INTO Applies (tutor_id,POST_ID) 
VALUES (4,5);
INSERT INTO Applies (tutor_id,POST_ID) 
VALUES (6,4);



INSERT INTO Applies (tutor_id,POST_ID) 
VALUES (8,3);
INSERT INTO Applies (tutor_id,POST_ID) 
VALUES (9,4);
INSERT INTO Applies (tutor_id,POST_ID) 
VALUES (9,5);
INSERT INTO Applies (tutor_id,POST_ID) 
VALUES (10,6);
INSERT INTO Applies (tutor_id,POST_ID) 
VALUES (10,7);

INSERT INTO Applies (tutor_id,POST_ID) 
VALUES (15,3);
INSERT INTO Applies (tutor_id,POST_ID) 
VALUES (16,4);
INSERT INTO Applies (tutor_id,POST_ID) 
VALUES (17,5);
INSERT INTO Applies (tutor_id,POST_ID) 
VALUES (18,6);
INSERT INTO Applies (tutor_id,POST_ID) 
VALUES (19,7);


INSERT INTO Applies (tutor_id,POST_ID) 
VALUES (22,3);
INSERT INTO Applies (tutor_id,POST_ID) 
VALUES (23,4);
INSERT INTO Applies (tutor_id,POST_ID) 
VALUES (24,5);
INSERT INTO Applies (tutor_id,POST_ID) 
VALUES (25,6);
INSERT INTO Applies (tutor_id,POST_ID) 
VALUES (26,7);

---- OFFER ----
-- DELETE FROM Notifications;
DELETE FROM Feedbacks;
INSERT INTO Feedbacks(rating,review)
VALUES (5,'Very good tutor');
INSERT INTO Feedbacks(rating,review)
VALUES (5,'Excellent teaching skill');
INSERT INTO Feedbacks(rating,review)
VALUES (5,'Very friendly');
INSERT INTO Feedbacks(rating,review)
VALUES (4,'Highly recommended.');

DELETE FROM Offers;
INSERT INTO Offers (student_id,tutor_id,tution_id,status,feedback_id) 
VALUES (1,5,13,'ACCEPTED',1);
INSERT INTO Offers (student_id,tutor_id,tution_id,status,feedback_id) 
VALUES (1,6,14,'ACCEPTED',2);

INSERT INTO Offers (student_id,tutor_id,tution_id,status,feedback_id) 
VALUES (2,4,15,'ACCEPTED',3);
INSERT INTO Offers (student_id,tutor_id,tution_id,status) 
VALUES (2,5,16,'PENDING');
INSERT INTO Offers (student_id,tutor_id,tution_id,status) 
VALUES (2,6,17,'PENDING');

INSERT INTO Offers (student_id,tutor_id,tution_id,status) 
VALUES (3,4,18,'PENDING');
INSERT INTO Offers (student_id,tutor_id,tution_id,status,feedback_id) 
VALUES (12,4,19,'ACCEPTED',4);
INSERT INTO Offers (student_id,tutor_id,tution_id,status) 
VALUES (13,5,20,'PENDING');
INSERT INTO Offers (student_id,tutor_id,tution_id,status) 
VALUES (14,4,21,'PENDING');

---- COACHING ----
DELETE FROM Coachings;
INSERT INTO Coachings (name,image,phone_number,address) 
VALUES ('Break The Fear','coaching1.jpg','01851953433','Ahmed Mansion, Monoharpur, Cumilla');
INSERT INTO Coachings (name,image,phone_number,address) 
VALUES ('Incredibles','coaching10.jpg','01711130955','Puraton chowdhuri para, Cumilla');
INSERT INTO Coachings (name,image,phone_number,address) 
VALUES ('Alphateach','coaching2.jpg','01711130955','69/C, Monipuri Para, Tejgaon');
INSERT INTO Coachings (name,image,phone_number,address) 
VALUES ('Brilliant Minds','coaching3.jpg','01978290355','Indira Road, Farmgate, Dhaka');
INSERT INTO Coachings (name,image,phone_number,address) 
VALUES ('Educatree','coaching5.jpg','01851953433','20, Central road, Dhanmondi Residential Aria');
INSERT INTO Coachings (name,image,phone_number,address) 
VALUES ('Education Hub','coaching6.jpg','01655567659','Samsur rahman road, Khulna, Khulna');
INSERT INTO Coachings (name,image,phone_number,address) 
VALUES ('Study Point','coaching8.jpg','01555556769','U-49, Noorjahan road, Mohammadpur, Dhaka');
INSERT INTO Coachings (name,image,phone_number,address) 
VALUES ('Coachify','coaching9.jpg','01313854014','145/28, Airport road super market (1st floor), Tejgaon, Dhaka');
INSERT INTO Coachings (name,image,phone_number,address) 
VALUES ('Instant Academy','coaching7.jpg','01755533650','Bakshibazar, Dhaka medical college and hospital, Dhaka');
INSERT INTO Coachings (name,image,phone_number,address) 
VALUES ('Bold Academy','coaching4.jpg','01755577908','House #285/3, Road #15 (old), Dhanmondi');


---- MEMBER_OF ----
DELETE FROM MemberOf;
INSERT INTO MemberOf (user_id,coaching_id,type) 
VALUES (4,1,'ADMIN');
INSERT INTO MemberOf (user_id,coaching_id,type) 
VALUES (5,2,'ADMIN');
INSERT INTO MemberOf (user_id,coaching_id,type) 
VALUES (4,3,'ADMIN');
INSERT INTO MemberOf (user_id,coaching_id,type) 
VALUES (4,4,'ADMIN');
INSERT INTO MemberOf (user_id,coaching_id,type) 
VALUES (4,5,'ADMIN');
INSERT INTO MemberOf (user_id,coaching_id,type) 
VALUES (4,6,'ADMIN');
INSERT INTO MemberOf (user_id,coaching_id,type) 
VALUES (4,7,'ADMIN');
INSERT INTO MemberOf (user_id,coaching_id,type) 
VALUES (4,8,'ADMIN');
INSERT INTO MemberOf (user_id,coaching_id,type) 
VALUES (4,9,'ADMIN');
INSERT INTO MemberOf (user_id,coaching_id,type) 
VALUES (4,10,'ADMIN');

INSERT INTO MemberOf (user_id,coaching_id,type) 
VALUES (1,1,'MEMBER');
INSERT INTO MemberOf (user_id,coaching_id,type) 
VALUES (1,2,'MEMBER');
INSERT INTO MemberOf (user_id,coaching_id,type) 
VALUES (1,3,'PENDING');
INSERT INTO MemberOf (user_id,coaching_id,type) 
VALUES (1,4,'MEMBER');
INSERT INTO MemberOf (user_id,coaching_id,type) 
VALUES (1,5,'MEMBER');
INSERT INTO MemberOf (user_id,coaching_id,type) 
VALUES (1,6,'MEMBER');
INSERT INTO MemberOf (user_id,coaching_id,type) 
VALUES (1,7,'MEMBER');

INSERT INTO MemberOf (user_id,coaching_id,type) 
VALUES (2,1,'MEMBER');
INSERT INTO MemberOf (user_id,coaching_id,type) 
VALUES (2,2,'MEMBER');
INSERT INTO MemberOf (user_id,coaching_id,type) 
VALUES (3,1,'MEMBER');

INSERT INTO MemberOf (user_id,coaching_id,type) 
VALUES (12,1,'MEMBER');
INSERT INTO MemberOf (user_id,coaching_id,type) 
VALUES (13,1,'PENDING');
INSERT INTO MemberOf (user_id,coaching_id,type) 
VALUES (14,1,'PENDING');
INSERT INTO MemberOf (user_id,coaching_id,type) 
VALUES (12,2,'PENDING');
INSERT INTO MemberOf (user_id,coaching_id,type) 
VALUES (13,3,'PENDING');
INSERT INTO MemberOf (user_id,coaching_id,type) 
VALUES (14,4,'PENDING');


---- COURSE ----
DELETE FROM Courses;
INSERT INTO Courses (coaching_id,class,subject)
VALUES (1,'Class 12','Math');
INSERT INTO Courses (coaching_id,class,subject)
VALUES (1,'Class 5','Bangla');
INSERT INTO Courses (coaching_id,class,subject)
VALUES (1,'Class 10','Math');
INSERT INTO Courses (coaching_id,class,subject)
VALUES (1,'Class 12','Physics');
INSERT INTO Courses (coaching_id,class,subject)
VALUES (2,'Class 12','Biology');
INSERT INTO Courses (coaching_id,class,subject)
VALUES (3,'Class 12','Bangla');
INSERT INTO Courses (coaching_id,class,subject)
VALUES (4,'Class 12','Math');
INSERT INTO Courses (coaching_id,class,subject)
VALUES (5,'Class 12','English');
INSERT INTO Courses (coaching_id,class,subject)
VALUES (6,'Class 12','ICT');
INSERT INTO Courses (coaching_id,class,subject)
VALUES (1,'Class 12','Chemistry');
INSERT INTO Courses (coaching_id,class,subject)
VALUES (1,'Class 12','Biology');
INSERT INTO Courses (coaching_id,class,subject)
VALUES (1,'Class 12','Higher Math');

---- BATCH ----
DELETE FROM Batches;
INSERT INTO Batches (course_id,start_date,seats,class_days,start_time,end_time)
VALUES (1,to_date('21-AUG-22','DD-MON-RR'),30,'Sun, Tue, Thu',to_date('07:00:00','HH24:MI:SS'),to_date('08:00:00','HH24:MI:SS'));
INSERT INTO Batches (course_id,start_date,seats,class_days,start_time,end_time)
VALUES (1,to_date('20-SEP-19','DD-MON-RR'),25,'Sat, Mon, Wed',to_date('08:00:00','HH24:MI:SS'),to_date('09:00:00','HH24:MI:SS'));
INSERT INTO Batches (course_id,start_date,seats,class_days,start_time,end_time)
VALUES (2,to_date('20-OCT-19','DD-MON-RR'),20,'Sun, Tue, Thu',to_date('09:00:00','HH24:MI:SS'),to_date('10:00:00','HH24:MI:SS'));
INSERT INTO Batches (course_id,start_date,seats,class_days,start_time,end_time)
VALUES (2,to_date('23-JUL-22','DD-MON-RR'),25,'Sat, Mon, Wed',to_date('10:00:00','HH24:MI:SS'),to_date('11:00:00','HH24:MI:SS'));
INSERT INTO Batches (course_id,start_date,seats,class_days,start_time,end_time)
VALUES (3,to_date('23-JUL-22','DD-MON-RR'),25,'Sun, Tue, Thu',to_date('11:00:00','HH24:MI:SS'),to_date('12:00:00','HH24:MI:SS'));
INSERT INTO Batches (course_id,start_date,seats,class_days,start_time,end_time)
VALUES (3,to_date('23-JUL-22','DD-MON-RR'),25,'Sun, Tue, Thu',to_date('12:00:00','HH24:MI:SS'),to_date('13:00:00','HH24:MI:SS'));
INSERT INTO Batches (course_id,start_date,seats,class_days,start_time,end_time)
VALUES(4,to_date('10-OCT-22','DD-MON-RR'),30,'Thu, Fri, Sat',to_date('13:00:00','HH24:MI:SS'),to_date('14:00:00','HH24:MI:SS'));
INSERT INTO Batches (course_id,start_date,seats,class_days,start_time,end_time)
VALUES(4,to_date('10-OCT-22','DD-MON-RR'),30,'Thu, Fri, Sat',to_date('14:00:00','HH24:MI:SS'),to_date('15:00:00','HH24:MI:SS'));
INSERT INTO Batches (course_id,start_date,seats,class_days,start_time,end_time)
VALUES (5,to_date('10-AUG-22','DD-MON-RR'),30,'Sat, Mon, Wed',to_date('15:00:00','HH24:MI:SS'),to_date('16:00:00','HH24:MI:SS'));
INSERT INTO Batches (course_id,start_date,seats,class_days,start_time,end_time)
VALUES (5,to_date('10-AUG-22','DD-MON-RR'),30,'Sat, Mon, Wed',to_date('16:00:00','HH24:MI:SS'),to_date('17:00:00','HH24:MI:SS'));
INSERT INTO Batches (course_id,start_date,seats,class_days,start_time,end_time)
VALUES (6,to_date('25-AUG-19','DD-MON-RR'),30,'Sun, Tue, Thu',to_date('17:00:00','HH24:MI:SS'),to_date('18:00:00','HH24:MI:SS'));
INSERT INTO Batches (course_id,start_date,seats,class_days,start_time,end_time)
VALUES (6,to_date('25-AUG-19','DD-MON-RR'),30,'Sun, Tue, Thu',to_date('07:00:00','HH24:MI:SS'),to_date('08:00:00','HH24:MI:SS'));
INSERT INTO Batches (course_id,start_date,seats,class_days,start_time,end_time)
VALUES (7,to_date('25-AUG-19','DD-MON-RR'),30,'Sat, Mon, Wed',to_date('08:00:00','HH24:MI:SS'),to_date('09:00:00','HH24:MI:SS'));
INSERT INTO Batches (course_id,start_date,seats,class_days,start_time,end_time)
VALUES (7,to_date('25-AUG-19','DD-MON-RR'),30,'Sun, Tue, Thu',to_date('09:00:00','HH24:MI:SS'),to_date('10:00:00','HH24:MI:SS'));
INSERT INTO Batches (course_id,start_date,seats,class_days,start_time,end_time)
VALUES (8,to_date('25-AUG-19','DD-MON-RR'),30,'Sat, Mon, Wed',to_date('11:00:00','HH24:MI:SS'),to_date('12:00:00','HH24:MI:SS'));
INSERT INTO Batches (course_id,start_date,seats,class_days,start_time,end_time)
VALUES (8,to_date('25-AUG-19','DD-MON-RR'),30,'Sun, Tue, Thu',to_date('12:00:00','HH24:MI:SS'),to_date('13:00:00','HH24:MI:SS'));
INSERT INTO Batches (course_id,start_date,seats,class_days,start_time,end_time)
VALUES (9,to_date('25-AUG-19','DD-MON-RR'),30,'Sat, Mon, Wed',to_date('13:00:00','HH24:MI:SS'),to_date('14:00:00','HH24:MI:SS'));
INSERT INTO Batches (course_id,start_date,seats,class_days,start_time,end_time)
VALUES (9,to_date('25-AUG-19','DD-MON-RR'),30,'Sun, Tue, Thu',to_date('14:00:00','HH24:MI:SS'),to_date('15:00:00','HH24:MI:SS'));
INSERT INTO Batches (course_id,start_date,seats,class_days,start_time,end_time)
VALUES (10,to_date('25-AUG-19','DD-MON-RR'),30,'Sat, Mon, Wed',to_date('15:00:00','HH24:MI:SS'),to_date('16:00:00','HH24:MI:SS'));
INSERT INTO Batches (course_id,start_date,seats,class_days,start_time,end_time)
VALUES (11,to_date('25-AUG-19','DD-MON-RR'),30,'Sun, Tue, Thu',to_date('16:00:00','HH24:MI:SS'),to_date('17:00:00','HH24:MI:SS'));
INSERT INTO Batches (course_id,start_date,seats,class_days,start_time,end_time)
VALUES (12,to_date('25-AUG-19','DD-MON-RR'),30,'Sat, Mon, Wed',to_date('17:00:00','HH24:MI:SS'),to_date('18:00:00','HH24:MI:SS'));

----  ENROLLED_IN ----
DELETE FROM EnrolledIn;
INSERT INTO EnrolledIn
VALUES(1,4,7,'APPROVED');
INSERT INTO EnrolledIn
VALUES(1,5,9,'APPROVED');
INSERT INTO EnrolledIn
VALUES(1,6,11,'APPROVED');
INSERT INTO EnrolledIn
VALUES(1,7,13,'APPROVED');
INSERT INTO EnrolledIn
VALUES(1,8,15,'APPROVED');
INSERT INTO EnrolledIn
VALUES(1,9,17,'APPROVED');

INSERT INTO EnrolledIn
VALUES(2,4,7,'APPROVED');
INSERT INTO EnrolledIn
VALUES(3,4,7,'APPROVED');
INSERT INTO EnrolledIn
VALUES(12,4,7,'PENDING');
INSERT INTO EnrolledIn
VALUES(2,7,13,'PENDING');
INSERT INTO EnrolledIn
VALUES(3,8,15,'PENDING');
INSERT INTO EnrolledIn
VALUES(12,9,17,'PENDING');


---- EDUCATIONS ----
DELETE FROM Educations;
INSERT INTO Educations(tutor_id,institute,field_of_study,degree,passing_year)
VALUES(4,'BUET','ME','BSC','2024');
INSERT INTO Educations(tutor_id,institute,field_of_study,degree,passing_year)
VALUES(4,'DC','Science','HSC','2018');
INSERT INTO Educations(tutor_id,institute,field_of_study,degree,passing_year)
VALUES(4,'CZS','Science','SSC','2015');
INSERT INTO Educations(tutor_id,institute,field_of_study,degree,passing_year)
VALUES(5,'BUET','EEE','BSC','2024');
INSERT INTO Educations(tutor_id,institute,field_of_study,degree,passing_year)
VALUES(5,'NDC','Science','HSC','2019');
INSERT INTO Educations(tutor_id,institute,field_of_study,degree,passing_year)
VALUES(5,'CZS','Science','SSC','2016');

DELETE FROM Notices;
INSERT INTO Notices(admin_id,coaching_id,class,subject,batch_id,text)
VALUES(4,1,'Class 12','Physics',-1,'Due to unwanted circumstances todays classes wont be taken');
INSERT INTO Notices(admin_id,coaching_id,class,subject,batch_id,text)
VALUES(4,3,'Class 12','Bangla',-1,'Next weekly test willl be held on next monday at 9:00 AM');
INSERT INTO Notices(admin_id,coaching_id,class,subject,batch_id,text)
VALUES(4,1,'Class 12','Physics',-1,'Weekly exam result is published. Result has been messaged to you');
INSERT INTO Notices(admin_id,coaching_id,class,subject,batch_id,text)
VALUES(4,4,'Class 12','Math',-1,'Prize giving ceremony will be held on friday');

DELETE FROM Materials;
INSERT INTO Materials(description,link,tutor_id,timestamp)
VALUES('Physics	HSC Chapter 3','https://www.youtube.com/watch?v=Q_jVrZRiGQY&list=PL1pf33qWCkmiPPekV3Piw12ttcFcVzCNB',6,TO_DATE('08/9/2022 10:00:00','MM/DD/YYYY HH24:MI:SS'));
INSERT INTO Materials(description,link,tutor_id,timestamp)
VALUES('Higher Math	Class 10 Chapter 1','https://www.youtube.com/watch?v=uT02Q5SBjro&list=PL1pf33qWCkmibUP3X3Xah-vGZk0MLhu-B&index=2',5,TO_DATE('08/29/2022 15:00:00','MM/DD/YYYY HH24:MI:SS'));
INSERT INTO Materials(description,link,tutor_id)
VALUES('Chemistry	Class 10 Chapter 2','https://www.youtube.com/watch?v=Ua9lH-m_Ups&list=PL1pf33qWCkmjTlgxZy8__IdmIs_3sTgqY&index=1',4);


DELETE FROM Classes;
INSERT INTO Classes VALUES(1,'Class 1');
INSERT INTO Classes VALUES(2,'Class 2');
INSERT INTO Classes VALUES(3,'Class 3');	
INSERT INTO Classes VALUES(4,'Class 4');
INSERT INTO Classes VALUES(5,'Class 5');
INSERT INTO Classes VALUES(6,'Class 6');
INSERT INTO Classes VALUES(7,'Class 7');
INSERT INTO Classes VALUES(8,'Class 8');
INSERT INTO Classes VALUES(9,'Class 9');
INSERT INTO Classes VALUES(10,'Class 10');
INSERT INTO Classes VALUES(11,'Class 11');
INSERT INTO Classes VALUES(12,'Class 12');
INSERT INTO Classes VALUES(13,'SSC');
INSERT INTO Classes VALUES(14,'HSC');
INSERT INTO Classes VALUES(15,'A Level');
INSERT INTO Classes VALUES(16,'O Level');
INSERT INTO Classes VALUES(17,'Admission');

DELETE FROM Mediums;
INSERT INTO Mediums VALUES(1,'Bangla Medium');
INSERT INTO Mediums VALUES(2,'English Medium');
INSERT INTO Mediums VALUES(3,'English Version');	
