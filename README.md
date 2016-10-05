# Project-Crypto

1.  Create a mySQL database "crypto" : 
    
    Query:
    
    `create database crypto;`
    
2.  Create new table "history_details" :

    +-----------+-------------+------+-----+---------+-------+
    | Field     | Type        | Null | Key | Default | Extra |
    +-----------+-------------+------+-----+---------+-------+
    | user_id   | varchar(50) | NO   |     | NULL    |       |
    | c_ed      | varchar(1)  | YES  |     | NULL    |       |
    | c_text    | text        | YES  |     | NULL    |       |
    | c_ed_type | varchar(1)  | YES  |     | NULL    |       |
    | c_c_text  | text        | YES  |     | NULL    |       |
    +-----------+-------------+------+-----+---------+-------+

    Query:
    
    `create table history_details(user_id varchar(50) NOT NULL, c_ed varchar(1), c_text TEXT, c_ed_type varchar(1), c_c_text TEXT);`
    
