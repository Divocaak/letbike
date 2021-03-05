# LETBIKE


## Databáze

mysql1: ^0.17.1
import 'package:mysql1/mysql1.dart';

[Návrh_databáze](https://dbdiagram.io/d/603a99cdfcdcb6230b21cb94)

### Item

- [ ] dateEnd jako DateTime
- [ ] jméno brázku = id + číslo obrázku + přípona

### User

### Chat

  id        | int(11)
| username  | varchar(20) 
| email     | varchar(320)
| password  | varchar(255)
| score     | int(11)     
| f_name    | varchar(50) 
| l_name    | varchar(50) 
| address_a | varchar(50) 
| address_b | varchar(50) 
| address_c | varchar(50) 
| postal    | int(10)     
| status    | tinyint(4)


id          | int(11)      | NO   | PRI | NULL                | auto_increment |
| seller_id   | int(11)      | NO   | MUL | NULL                |                |
| name        | varchar(200) | YES  |     | NULL                |                |
| description | varchar(200) | YES  |     | NULL                |                |
| price       | float(9,2)   | NO   |     | NULL                |                |
| score       | int(11)      | YES  |     | NULL                |                |
| paid        | tinyint(1)   | YES  |     | NULL                |                |
| date_start  | timestamp    | NO   |     | CURRENT_TIMESTAMP   |                |
| date_end    | timestamp    | NO   |     | 0000-00-00 00:00:00 |                |
| imgs        | varchar(255) | YES  |     | NULL                |                |
| status      | tinyint(4)