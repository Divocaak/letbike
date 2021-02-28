# LETBIKE


## Databáze

- [ ] upravit metody v dbAcces.php
- [ ] upravit metody v dbServices.dart

1. vložení produktu
    * obrázky:
        * jméno = id + číslo obrázku + přípona
        * při větším počtu obrázků používat oddělovač "|"
    * příkaz: 
        * __bez přidávání id jako předponu k názvu obrázku!__

        ```SQL
        INSERT INTO item (seller_id, name, description, price, score, paid, date_end, imgs, status)
        VALUES (0, "", "", 00.00, 0, 0, "0000-00-00 00:00:00 AM","0.jpg|1.jpg|2.jpg", 0);
        ```



[Návrh_databáze](https://dbdiagram.io/d/603a99cdfcdcb6230b21cb94)