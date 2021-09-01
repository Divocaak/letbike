# LETBIKE

## Databáze

[Návrh_databáze](https://dbdiagram.io/d/603a99cdfcdcb6230b21cb94)


## TODO

- [x] log reg
    - [x] alert box při špatné validaci
        - [x] login
        - [x] register
    - [x] zbavit se zbytečných závislostí (fonty, ...)
    - [x] vyřešit error při úspešném loginu
    - [x] náhodný obrázek na pozadí
- [x] homescreen
    - [x] warning card (doplnit uživatelské údaje)
    - [x] zužitkování ostatních dat na itemcard
    - [x] tlačítko na filtry
- [x] getItem a setItem => itemGet && itemSet
- [x] itemscreen
    - [x] zužitkování ostatních dat
    - [x] appbar odstranit, předělat na tlačítko
        - [x] pokud jsem autor
            - [x] skrýt pro ostatní (Skrýt/Rezerováno)
                - [x] + potvrzení
            - [x] prodáno
                - [x] + potvrzení
        - [x] parametry (alertbox)
        - [x] chat(y)
        - [x] zpět
- [x] addItem
    - [x] response (success || error) při addItem
    - [x] obrázky u addItem
        - [x] úvodní (1)
        - [x] detaily (víc, id = id + 1);
    - [x] deprecated věci nahradit (addItem)
    - [x] upravit seznamy.dart na více Tříd, tohle je hnus
    - [x] appbar odstranit, předělat na tlačítko addItem
    - [x] TextField upravit na můj custom input na addItem
- [x] vytvořit general.dart
    - [x] export objects.dart
        - [x] vztvorit objects.dart
    - [x] export widgets.dart
        - [x] vztvorit widgets.dart
            - [x] circularbutton
            - [x] imagepicker
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
- [x] fontawesome odstranit
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
- [x] logout (někde)
- [x] hodnocení
    - [x] v chatu tlačítko "prodat"
        - [x] skryje se
    - [x] u kupujícího se zobrazí inzerát v listu koupeno
        - [x] po kliknutí formulář na hodnocení  
- [x] textfields utf8 encoding, háčky a čárky pls
    - [x] account settings
    - [x] chat
- [x] chat list - nezobrazovat sám sebe xd
- [x] ohodnocené (tzn. uzavřené) předměty na accScreen
- [x] zorbrazení ratingů
    - [x] account screen
    - [x] v chatu (otherUser info nebo jak);
- [x] nahrávání prof pic háže chypu při žádném obrázku
- [x] charset response ze serveru
- [x] barvy (všechno do černý) nebo obrázky na pozadí
    - [x] app
    - [x] alertbox
- [x] filtry opravit
- [x] article
    - [x] encoding, charset
    - [x] obrázci
- [x] chat
    - [x] umožnit posílat zprávy menší než 2 znaky
    - [x] mazat inputfield po odeslání zprávy
    - [x] zakázat chat sám se sebou
    - [x] opravit seznam chatů (idk, bugnul)
    - [x] opravit zobrazování zpráv (pokud jsem inzerent)
    - [x] udělat něco s refreshem? zpráva se zobrazí po dlouhé době;
    - [x] zamezit odesílání prázdných zpráv, asi povolit poslání obrázku s textem
    - [x] tlačítko na zobrazení userInfo toho druhého
- [x] opravit barvu textu
    - [x] psaní recenze
    - [x] response ze serveru (někde (registrace a login určitě))
- [x] zapamatovat přihlášení
    - [x] bez textinputcontrolleru to dělat nebudu :D
- [x] opravit warning card
- [x] doplnit kategorie
- [x] refreshnout homepage po přidání inzerátu (nový inzerát se nezobrazuje, snad je to tím)
- [x] register
    - [x] souhlasím se zpracováním os. údajů
    - [x] souhlasím s všeobecnými podmínky (uloženo na serveru, odkaz na ně)
- [ ] co mi ulehčí práci
    - [x] používat textinputcontroller (asi všude xd)
    - [ ] image picker do samostatného widgetu!
    - [x] kategorie a filtry (upravit a zkrátit nějak)
        - [x] Dropdown
        - [x] Switch
- [x] možná zrušit počet obrázků v db, záleží na čtení obrázků v .md souboru
- [ ] __před releasem__
    - [ ] až bude hosting
        - [ ] ověřit mail
        - [ ] forgot password
    - [ ] změnit adresu serveru
        - [ ] general.dart
        - [ ] dbServices.dart
    - [ ] test na jiných emulátorech (jiné rozlišení)
    - [ ] killswitch debile!
- [x] encoding u každý response (udělat jako u articlu)
- [x] charset a collation v databázi
- [x] zjistit a snad vyřešit co je "unknown param ?.????????"
- [x] addItem dodělávky
    - [x] upravit zobrazování parametrů (např. Odpružená == true {zobrazit typ odpuržení}, ...)
    - [x] pozadí
- [x] filtry dodělávky
    - [x] upravit zobrazování parametrů (např. Odpružená == true {zobrazit typ odpuržení}, ...)
    - [x] pozadí
- [x] clickable celou item card, ne jenom obrázek
- [x] nové filtry do a z db, zoptializovat (nová tabulka?)
- [x] tabulka filtrů na filtersPage
- [ ] otestovat
    - [ ] filtrování
    - [x] zobrazování zadaných parametrů při přidávání itemu
    - [x] zobrazování parametrů na itemScreen
- [x] doplnit nové parametry do ParamRow v categories.dart
- [x] opravit
    - [x] po vyplnění parametrů předmětu nemazat jméno, popis, cenu ani obrázky
    - [x] zobrazování na homepage nefunguje
    - [x] po přidání itemu resetovat filtry na homepage
    - [x] nějakej bug při zadávání parametrů, nastaví se jiný :D ;(


## Article

* ukládat jako article.md
    * encoding utf-8
* obrázky
    * minimálně jeden
        * pojmenovat 0.jpg, bude použit jako náhled
    * cesta __absolutní__ (až na server, nutno uvést http://)


## Item parameters

used,
selectedCategory,
bikeBrand,
bikeType,
selectedParts,
wheelBrand,
wheelSize,
wheelMaterial,
wheeldSpokes,
wheeldType,
wheelAxis,
wheeldBrakesType,
wheeldBrakesDisc,
wheeldCassette,
wheelNut,
wheelCompatibility,
cranksBrand,
cranksCompatibility,
cranksMaterial,
cranksAxis,
converterBrand,
converterNumOfSpeeds,
saddleBrand,
saddleGender,
forkBrand,
forkSize,
forkSuspension,
forkSuspensionType,
forkWheelCoompatibility,
forkMaterial,
forkMaterialColumn,
selectedAccessories,
selectedOther,
eBikeBrand,
eBikeMotorPos,
trainerBrand,
trainerBrakes,
scooterBrand,
scooterSize,
scooterComputer,
brakeType,
brakeBrand,
brakeDiscType,
brakeDiscSize,
brakeBlockType,
tireSize,
tireWidth,
tireBrand,
tireType,
tireMaterial,
tubeSize,
tubeType,
frameSize,
frameFork,
frameType,
handlebarType,
handlebarMaterial,
handlebarWidth,
handlebarSize,
saddleTubeTube,
saddleTubeLength,
saddleTubeMaterial,
saddleTubeSize,
stemType,
axisType,
cassetteType,
shockAbsType,
gearChangeType,
pedalsType,
rimSize,
gripsType,
eBikeComponentsType,
headsetType,
bowdenType,
clothesType,
clothesClothes,
clothesGender,
clothesSize,
bootsType,
bootsSize,
helmetType,
compType,
glassType,
glassGlass,
glassGender,
glassGlassChange,
glassHolderChange,
kidSaddleType,
bottleHolderType,
rackType,
rackSize,
carRackType,
toolType,
pumpType,
lightType,
mudguardType,
mudguardSize,
lockType