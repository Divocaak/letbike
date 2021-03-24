# LETBIKE

## Databáze

[Návrh_databáze](https://dbdiagram.io/d/603a99cdfcdcb6230b21cb94)

- [x] getItem a setItem => itemGet && itemSet
- [ ] vytvořit general.dart
    - [ ] export classes.dart
        - [ ] vztvorit classes.dart
    - [ ] export widgets.dart
        - [ ] vztvorit widgets.dart
            - [x] circularbutton od Lukáše
            - [ ] imagepicker od Bčka
            - [x] roundedButton
                - [x] registrace
                - [x] login
            - [x] textinputfield
                - [x] text
                - [x] heslo
                    - [x] zakrýt hesla!
                - [x] email
    - [ ] export dbServices.dart
- [x] snad všechny talčítka: po pushNamed sbalit
- [x] pošéfovat barvy
- [ ] reload stránek po popu
- [x] fontawesome mrdka
- [x] password change
- [x] buildCard do widgets.dart
- [ ] obrázky
    - [ ] nahrávání
        - [ ] item
        - [ ] accountSettings
        - [ ] chat zpráva
    - [ ] zobrazování
        - [ ] item
            - [ ] homepage
            - [ ] account
            - [ ] itempage
        - [ ] accountSettings
            - [ ] settings
            - [ ] details
        - [ ] chat
            - [ ] zpráva
            - [ ] profil

## App Content


### Home Screen

- [x] skupina __A__
    - [x] příjem na GitHubu
    - [x] staženo
    - [x] moje hotovo
    - [x] master na GitHubu
- [x] banner (doplnit uživatelské údaje)
- [x] zužitkování ostatních dat


### Item Screen

- [x] skupina __B__
    - [x] příjem na GitHubu
    - [x] staženo
    - [x] moje hotovo
    - [x] master na GitHubu
- [x] dateEnd jako DateTime
- [x] zužitkování ostatních dat
- [ ] appbar odstranit, předělat na tlačítko
    - [ ] parametry (alertbox)
    - [x] chat(y)
    - [x] zpět


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


### Add Item

- [ ] skupina __B__
    - [x] příjem na GitHubu
    - [x] staženo
    - [ ] moje hotovo
    - [ ] master na GitHubu
- [ ] response (success || error)
- [ ] jméno brázku = ../imgs/id/číslo obrázku
- [x] deprecated věci nahradit
- [x] upravit seznamy.dart na více Tříd, tohle je hnus
- [ ] appbar odstranit, předělat na tlačítko


### Chat Screen

- [x] skupina __A__
    - [x] příjem na GitHubu
    - [x] staženo
    - [x] moje hotovo
    - [x] master na GitHubu
- [ ] načíst obrázek z databáze
- [ ] umožnit posílat zprávy menší než 4 znaky
- [ ] mazat inputfield po odeslání zprávy
- [x] zakázat chat sám se sebou
- [ ] opravit seznam chatů (idk, bugnul)
- [ ] opravit zobrazování zpráv
- [ ] udělat něco s refreshem? zpráva se zobrazí po dlouhé době;


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