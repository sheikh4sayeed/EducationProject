<h2 align="center">DEDUCATION DATABASE</h3>

![dEducation-logo](https://user-images.githubusercontent.com/62663759/187912013-d1653a15-833a-4102-9091-0c9aa96b8505.png)

## About The Project

dEducation is an ed-tech platform where tutors,students and coaching centers get connected to each other. Students can find their desired tutors and join coaching centers. On the other hand, tutors can get tuitions and create their own coaching centers.

## ERD

![Copy of Hidden-Brain-ERD2 drawio(2)](https://user-images.githubusercontent.com/62663759/187913372-7e328aa0-2099-4b8d-8f95-5aa119d017c9.png)

## Languages, Tools and Frameworks:<a name="tools"></a>

- Oracle 19C
- Navicat Premium

## Getting Started

Follow the step by step installation procedure to install and run this on your machine

## Prerequisites

Make sure you have oracle installed in your device.

**`Oracle`**: Install Oracle from [here](http://www.oracle.com/index.html) and register for an account of your own

## Setting up the database

1. Go to sql plus

2. Enter credentials

   ```sh
   username: sys as sysdba
   password: password
   ```

3. Create a new user c##deducation

```sh
create user c##deducation identified by password;
grant dba to c##deducation;
```

5. Head over to your favourite database GUI and connect deducation with that.

6. Import data from sql file depending upon the GUI.

7. List of sql files:

```sh
- tables/CREATE_ALL_TABLES.sql
- types/CREATE_TYPES.sql
- triggers/CREATE_TRIGGERS.sql
- functions/CREATE_FUNCTION_PROCEDURES.sql
- data/GENERATE_SAMPLE_DATA.sql
```

8. If no errors are shown we are good to go!

## Supervisor

- Khaled Mahmud Shahriar

  - **Assistant Professor**

    :arrow_forward: **Contact:**

    Department of Computer Science and Engineering
    Bangladesh University of Engineering and Technology
    Dhaka-1000, Bangladesh

<p align="right">(<a href="#top">back to top</a>)</p>
