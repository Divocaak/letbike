# LETBIKE

## Databáze

[Návrh_databáze](https://dbdiagram.io/d/603a99cdfcdcb6230b21cb94)

- [x] getItem a setItem => itemGet && itemSet
- [x] vytvořit general.dart
    - [x] export objects.dart
        - [x] vztvorit objects.dart
    - [x] export widgets.dart
        - [x] vztvorit widgets.dart
            - [x] circularbutton od Lukáše
            - [x] imagepicker od Bčka
            - [x] roundedButton
                - [x] registrace
                - [x] login
            - [x] textinputfield
                - [x] text
                - [x] heslo
                    - [x] zakrýt hesla!
                - [x] email
    - [x] export dbServices.dart
- [x] snad všechny talčítka: po pushNamed sbalit
- [x] pošéfovat barvy
- [x] reload stránek po popu
    - [x] accSett => accScreen
    - [x] accScreen => homePage
    - [x] addItem => homePage
    - [x] filters => homePage
- [x] fontawesome mrdka
- [x] password change
- [x] buildCard do widgets.dart
- [x] obrázky
    - [x] nahrávání
        - [x] item
        - [x] accountSettings
        - [x] chat zpráva
            - [x] imgs/messages/itemId + from + to/ identifikátor obrázku (možná index zprávy)
                - [x] itemId, from a to nejprve převést na string, poté spojit (ne sečíst čísla)
    - [x] zobrazování
        - [x] item
            - [x] homepage
            - [x] account
            - [x] itempage
        - [x] account
            - [x] settings
            - [x] details
        - [x] zpráva v chatu 
- [ ] test na jiných emulátorech (jiné rozlišení)
- [x] logout (někde)
- [ ] charset response ze serveru
- [ ] hodnocení
    - [x] v chatu tlačítko "prodat"
        - [x] skryje se
    - [ ] u kupujícího se zobrazí inzerát v listu koupeno
        - [ ] po kliknutí formulář na hodnocení  
- [ ] image picker do samostatného widgetu!
- [ ] textfields utf8 encoding, háčky a čárky pls
    - [ ] account settings
    - [ ] chat
- [ ] doplnit kategorie
- [ ] chat list - nezobrazovat sám sebe xd
 

## App Content


### Home Screen

- [x] skupina __A__
    - [x] příjem na GitHubu
    - [x] staženo
    - [x] moje hotovo
    - [x] master na GitHubu
- [x] banner (doplnit uživatelské údaje)
- [x] zužitkování ostatních dat
- [x] tlačítko na filtry


### Item Screen

- [x] skupina __B__
    - [x] příjem na GitHubu
    - [x] staženo
    - [x] moje hotovo
    - [x] master na GitHubu
- [x] dateEnd jako DateTime
- [x] zužitkování ostatních dat
- [ ] appbar odstranit, předělat na tlačítko
    - [x] parametry (alertbox)
    - [x] chat(y)
    - [x] zpět
    - [ ] pokud jsem autor
        - [ ] skrýt pro ostatní (Skrýt/Rezerováno)
            - [ ] + potvrzení
        - [ ] prodáno
            - [ ] + potvrzení


### Login & Register

- [x] skupina __A__
    - [x] příjem na GitHubu
    - [x] staženo
    - [x] moje hotovo
    - [x] master na GitHubu
- [x] alert box při špatné validaci
    - [x] login
    - [x] register
- [x] zbavit se zbytečných závislostí (fonty, ...)
- [ ] zapomenuté heslo
- [ ] zapamatovat přihlášení
- [x] vyřešit error při úspešném loginu
- [x] náhodný obrázek na pozadí


### Add Item

- [x] skupina __B__
    - [x] příjem na GitHubu
    - [x] staženo
    - [x] moje hotovo
    - [x] master na GitHubu
- [x] response (success || error)
- [x] obrázky
    - [x] úvodní (1)
    - [x] detaily (víc, id = id + 1);
- [x] deprecated věci nahradit
- [x] upravit seznamy.dart na více Tříd, tohle je hnus
- [x] appbar odstranit, předělat na tlačítko
- [x] TextField upravit na můj custom input
- [ ] upravit, zkrátit
    - [ ] Dropdown
    - [ ] Switch
- [ ] upravit zobrazování parametrů (např. Odpružená == true {zobrazit typ odpuržení}, ...)
- [ ] náhodný obrázek na pozadí


### Chat Screen

- [x] skupina __A__
    - [x] příjem na GitHubu
    - [x] staženo
    - [x] moje hotovo
    - [x] master na GitHubu
- [x] umožnit posílat zprávy menší než 2 znaky
- [x] mazat inputfield po odeslání zprávy
- [x] zakázat chat sám se sebou
- [x] opravit seznam chatů (idk, bugnul)
- [x] opravit zobrazování zpráv (pokud jsem inzerent)
- [ ] udělat něco s refreshem? zpráva se zobrazí po dlouhé době;
- [x] zamezit odesílání prázdných zpráv, asi povolit poslání obrázku s textem
- [x] tlačítko na zobrazení userInfo toho druhého


### Fitry

- [ ] __JÁ__
    - [ ] moje hotovo
    - [ ] master na GitHubu


### Account

- [x] skupina __A__
    - [x] příjem na GitHubu
    - [x] staženo
    - [x] moje hotovo
    - [x] master na GitHubu
- [x] postavit, Lukáš je kokot