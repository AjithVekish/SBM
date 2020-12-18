CREATE DATABASE sbm; 

USE sbm; 

DROP TABLE sbm.user_auth;
CREATE TABLE sbm.user_auth (
  user_id INT NOT NULL,
  token varchar(250) NOT NULL,
  update_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE sbm.profile_route;
CREATE TABLE sbm.profile_route(
  route_id INT AUTO_INCREMENT NOT NULL,
  route_name varchar(55),
  update_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  state TINYINT DEFAULT 0,
  PRIMARY KEY (route_id),
  UNIQUE KEY (route_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE sbm.profile_stop;
CREATE TABLE sbm.profile_stop(
  stop_id BIGINT AUTO_INCREMENT NOT NULL,
  stop_name varchar(55) NOT NULL,
  latitude varchar(22),
  longitude varchar(22),
  update_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  state TINYINT DEFAULT 0,
  PRIMARY KEY (stop_id),
  UNIQUE KEY (stop_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE sbm.map_route_stop;
CREATE TABLE sbm.map_route_stop(
  map_id INT AUTO_INCREMENT NOT NULL,
  route_id INT NOT NULL,
  stop_id INT NOT NULL,
  position INT NOT NULL,
  update_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  state TINYINT DEFAULT 0,
  PRIMARY KEY (map_id),
  UNIQUE KEY (route_id, stop_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE sbm.profile_camera;
CREATE TABLE sbm.profile_camera(
  camera_id BIGINT AUTO_INCREMENT NOT NULL,
  camera_ip varchar(22) NOT NULL,
  bus_id INT DEFAULT NULL,
  url varchar(88) DEFAULT NULL,
  update_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  state TINYINT DEFAULT 0,
  PRIMARY KEY (camera_id),
  UNIQUE KEY (bus_id, camera_ip)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE sbm.profile_bus;
CREATE TABLE sbm.profile_bus(
  bus_id INT NOT NULL,
  route_id INT DEFAULT NULL,
  driver_id INT,
  staff_id INT,
  num_students INT,
  latitude varchar(22),
  longitude varchar(22),
  nextstop_id INT,
  update_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  state TINYINT DEFAULT 0,
  PRIMARY KEY (bus_id),
  UNIQUE KEY (bus_id, route_id, staff_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE sbm.profile_student;
CREATE TABLE sbm.profile_student(
  student_id BIGINT AUTO_INCREMENT NOT NULL,
  parent_id INT,
  bus_id INT,
  stop_id INT,
  rfid varchar(52) DEFAULT NULL,
  full_name VARCHAR(150) DEFAULT NULL,
  stop_name varchar(55),
  img_url varchar(52) DEFAULT NULL,
  gender ENUM('Male', 'Female') NOT NULL DEFAULT 'Male',
  date_of_birth DATE,
  update_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  state TINYINT DEFAULT 0,
  PRIMARY KEY (student_id),
  UNIQUE KEY (bus_id, parent_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE sbm.profile_parent;
CREATE TABLE sbm.profile_parent(
  parent_id BIGINT AUTO_INCREMENT NOT NULL,
  phone_number varchar(12) NOT NULL,
  pwd varchar(33) DEFAULT NULL,
  otp int(5) DEFAULT NULL,
  img_url varchar(52)DEFAULT NULL,
  update_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  state TINYINT DEFAULT 0,
  PRIMARY KEY (parent_id),
  UNIQUE KEY (parent_id)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8;

DROP TABLE sbm.profile_staff;
CREATE TABLE sbm.profile_staff(
  staff_id BIGINT AUTO_INCREMENT NOT NULL,
  bus_id INT ,
  full_name varchar(12) NOT NULL,
  role varchar(12) NOT NULL,
  img_url varchar(52)DEFAULT NULL,
  pwd varchar(250) DEFAULT NULL,
  update_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  state TINYINT DEFAULT 0,
  PRIMARY KEY (staff_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE sbm.parent_image;
CREATE TABLE sbm.parent_image (
  img_id BIGINT AUTO_INCREMENT NOT NULL,
  parent_id INT NOT NULL,
  img_url varchar(52) NOT NULL,
  update_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  state TINYINT DEFAULT 0,
  PRIMARY KEY (img_id),
  UNIQUE KEY (parent_id, img_url)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE sbm.daily_attendance;
CREATE TABLE sbm.daily_attendance (
  attendance_id BIGINT AUTO_INCREMENT NOT NULL,
  rfid varchar(52) DEFAULT NULL,
  student_id INT NOT NULL,
  parent_id INT NOT NULL,
  bus_id INT NOT NULL,
  stop_id INT NOT NULL,
  status ENUM('IN', 'OUT') NOT NULL DEFAULT 'OUT',
  update_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (attendance_id),
  UNIQUE KEY (rfid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE sbm.attendance_time;
CREATE TABLE sbm.attendance_time (
  time_id BIGINT AUTO_INCREMENT NOT NULL,
  attendance_id INT NOT NULL,
  attendance_time TIME,
  status ENUM('IN', 'OUT') NOT NULL DEFAULT 'OUT',
  update_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (time_id),
  UNIQUE KEY (attendance_id, attendance_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE sbm.daily_schedule;
CREATE TABLE sbm.daily_schedule (
  schedule_id BIGINT AUTO_INCREMENT NOT NULL,
  parent_id INT NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  img_url varchar(52) NOT NULL,
  bus_id INT NOT NULL,
  stop_id INT NOT NULL,
  update_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  state TINYINT DEFAULT 0,
  PRIMARY KEY (schedule_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;








