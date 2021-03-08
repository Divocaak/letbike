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

json["sellerId"] as int,
        json["name"] as String,
        json["description"] as String,
        json["price"] as double,
        json["score"] as int,
        json["paid"] as int,
        json["dateEnd"] as String,
        json["imgs"] as String,
        json["status"] as int);