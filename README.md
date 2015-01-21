Doctor Office DB
================

by Grace Mekarski and Mike Goren

Doctor Office DB is a website that uses a database and Sinatra to allow administrators to track doctors and patients.

Installation
------------

Install Doctor Office DB by first cloning the repository.  
```
$ git clone http://github.com/gracelauren/doctoroffice.git
```

Install all of the required gems:
```
$ bundle install
```

Start the database:
```
$ postgres
```

Create the databases and tables:
```
# psql
```

```
username=# CREATE DATABASE doctor_office;
```

```
username=# \c doctor_office;
```

```
todo=# CREATE TABLE doctors (id serial PRIMARY KEY, name varchar, specialty_id int);
```

```
todo=# CREATE TABLE patients (id serial PRIMARY KEY, name varchar, birthdate date);
```

```
todo=# CREATE TABLE specialties (id serial PRIMARY KEY, specialty varchar);
```

```
todo=# CREATE DATABASE doctor_office_test WITH TEMPLATE doctor_office;
```

Start the webserver:
```
$ ruby app.rb
```

In your web browser, go to http://localhost:4567

License
-------

GNU GPL v2. Copyright 2015 Mike Goren and Grace Mekarski
