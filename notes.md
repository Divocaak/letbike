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
- [ ] test na jiných emulátorech (jiné rozlišení)
- [x] logout (někde)
- [ ] charset response ze serveru
- [ ] hodnocení
    - [ ] v chatu tlačítko "prodat"
        - [ ] skryje se
    - [ ] u kupujícího se zobrazí inzerát v listu koupeno
        - [ ] po kliknutí formulář na hodnocení  
- [ ] image picker do samostatného widgetu!


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

- [ ] skupina __B__
    - [x] příjem na GitHubu
    - [x] staženo
    - [ ] moje hotovo
    - [ ] master na GitHubu
- [x] response (success || error)
- [ ] obrázky
    * jméno brázku = ../imgs/id/číslo obrázku
    - [ ] úvodní (1)
    - [ ] detaily (víc, id = id + 1);
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
- [ ] načíst obrázek z databáze
- [ ] umožnit posílat zprávy menší než 2 znaky
- [ ] mazat inputfield po odeslání zprávy
- [x] zakázat chat sám se sebou
- [ ] opravit seznam chatů (idk, bugnul)
- [ ] opravit zobrazování zpráv
- [ ] udělat něco s refreshem? zpráva se zobrazí po dlouhé době;
- [ ] proklik na account info


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