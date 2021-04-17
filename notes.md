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
- [ ] opravit warning card
- [ ] doplnit kategorie
- [ ] killswitch debile!
- [x] refreshnout homepage po přidání inzerátu (nový inzerát se nezobrazuje, snad je to tím)
- [x] register
    - [x] souhlasím se zpracováním os. údajů
    - [x] souhlasím s všeobecnými podmínky (uloženo na serveru, odkaz na ně)
- [ ] co mi ulehčí práci
    - [x] používat textinputcontroller (asi všude xd)
    - [ ] image picker do samostatného widgetu!
    - [ ] kategorie a filtry (upravit a zkrátit nějak)
        - [ ] Dropdown
        - [ ] Switch
- [x] možná zrušit počet obrázků v db, záleží na čtení obrázků v .md souboru
- [ ] __před releasem__
    - [ ] až bude hosting
        - [ ] ověřit mail
        - [ ] forgot password
    - [ ] změnit adresu serveru
        - [ ] general.dart
        - [ ] dbServices.dart
    - [ ] test na jiných emulátorech (jiné rozlišení)
- [x] encoding u každý response (udělat jako u articlu)
- [x] charset a collation v databázi
- [ ] zjistit a snad vyřešit co je "unknown param ?.????????"
- [ ] addItem dodělávky
    - [ ] upravit zobrazování parametrů (např. Odpružená == true {zobrazit typ odpuržení}, ...)
    - [ ] pozadí
- [ ] filtry dodělávky
    - [ ] upravit zobrazování parametrů (např. Odpružená == true {zobrazit typ odpuržení}, ...)
    - [ ] pozadí
- [x] clickable celou item card, ne jenom obrázek



## App Content

* jednotlivé stránky
* progress u stránek

### Article

* skupina __JÁ__

* ukládat jako article.md
    * encoding utf-8
* obrázky
    * minimálně jeden
        * pojmenovat 0.jpg, bude použit jako náhled
    * cesta __absolutní__ (až na server, nutno uvést http://)

- [x] moje hotovo
- [x] master na GitHubu



### Home Screen

* skupina __A__

- [x] příjem na GitHubu
- [x] staženo
- [x] moje hotovo
- [x] master na GitHubu



### Item Screen

* skupina __B__

- [x] příjem na GitHubu
- [x] staženo
- [x] moje hotovo
- [x] master na GitHubu



### Login & Register

* skupina __A__

- [x] příjem na GitHubu
- [x] staženo
- [x] moje hotovo
- [x] master na GitHubu



### Add Item

* skupina __B__

- [x] příjem na GitHubu
- [x] staženo
- [x] moje hotovo
- [x] master na GitHubu



### Chat Screen

* skupina __A__

- [x] příjem na GitHubu
- [x] staženo
- [x] moje hotovo
- [x] master na GitHubu



### Fitry

* skupina __JÁ__

- [x] moje hotovo
- [x] master na GitHubu



### Account

* skupina __A__

- [x] příjem na GitHubu
- [x] staženo
- [x] moje hotovo
- [x] master na GitHubu



KATEGORIE                                   

- KOMPONENT
    
- - VÝPLET
            return Column(
              children: [
                DropdownButton(
                  hint: Text("Značka"),
                  value:
                      wheel.selectedBrand,
                  onChanged: (newValue) {
                    setState(() {
                      wheel.selectedBrand =
                          newValue;
                    });
                  },
                  items: Wheel.brand
                      .asMap()
                      .entries
                      .map((entry) {
                    return DropdownMenuItem(
                      child: new Text(
                          entry.value),
                      value: entry.key,
                    );
                  }).toList(),
                ),
                DropdownButton(
                  hint: Text("Velikost"),
                  value:
                      wheel.selectedSize,
                  onChanged: (newValue) {
                    setState(() {
                      wheel.selectedSize =
                          newValue;
                    });
                  },
                  items: Wheel.size
                      .asMap()
                      .entries
                      .map((entry) {
                    return DropdownMenuItem(
                      child: new Text(
                          entry.value),
                      value: entry.key,
                    );
                  }).toList(),
                ),
                DropdownButton(
                  hint: Text("Materiál"),
                  value: wheel
                      .selectedMaterial,
                  onChanged: (newValue) {
                    setState(() {
                      wheel.selectedMaterial =
                          newValue;
                    });
                  },
                  items: Wheel.material
                      .asMap()
                      .entries
                      .map((entry) {
                    return DropdownMenuItem(
                      child: new Text(
                          entry.value),
                      value: entry.key,
                    );
                  }).toList(),
                ),
                Row(children: [
                  Text(
                      "Typ drátů: Kulaté "),
                  Switch(
                    value: wheel
                        .selectedSpokes,
                    onChanged: (value) {
                      setState(() {
                        wheel.selectedSpokes =
                            value;
                      });
                    },
                  ),
                  Text(" Ploché")
                ]),
                Row(children: [
                  Text(
                      "Provedení náboje: Přední "),
                  Switch(
                    value: wheel
                        .selectedType,
                    onChanged: (value) {
                      setState(() {
                        wheel.selectedType =
                            value;
                      });
                    },
                  ),
                  Text(" Zadní")
                ]),
                DropdownButton(
                  hint: Text(
                      "Provedení osy"),
                  value:
                      wheel.selectedAxis,
                  onChanged: (newValue) {
                    setState(() {
                      wheel.selectedAxis =
                          newValue;
                    });
                  },
                  items: Wheel.axis
                      .asMap()
                      .entries
                      .map((entry) {
                    return DropdownMenuItem(
                      child: new Text(
                          entry.value),
                      value: entry.key,
                    );
                  }).toList(),
                ),
                Row(children: [
                  Text(
                      "Typ brzd: Kotoučové "),
                  Switch(
                    value: wheel
                        .selectedBrakesType,
                    onChanged: (value) {
                      setState(() {
                        wheel.selectedBrakesType =
                            value;
                      });
                    },
                  ),
                  Text(" V-Brzdy")
                ]),
                Row(children: [
                  Text(
                      "Uchycení disku: CenterLock "),
                  Switch(
                    value: wheel
                        .selectedBrakesDisc,
                    onChanged: (value) {
                      setState(() {
                        wheel.selectedBrakesDisc =
                            value;
                      });
                    },
                  ),
                  Text(" 6 děr")
                ]),
                Row(children: [
                  Text(
                      "Provedení kazety: Závit "),
                  Switch(
                    value: wheel
                        .selectedCassette,
                    onChanged: (value) {
                      setState(() {
                        wheel.selectedCassette =
                            value;
                      });
                    },
                  ),
                  Text(" Ořech")
                ]),
                DropdownButton(
                  hint: Text(
                      "Značka ořechu"),
                  value:
                      wheel.selectedNut,
                  onChanged: (newValue) {
                    setState(() {
                      wheel.selectedNut =
                          newValue;
                    });
                  },
                  items: Wheel.nut
                      .asMap()
                      .entries
                      .map((entry) {
                    return DropdownMenuItem(
                      child: new Text(
                          entry.value),
                      value: entry.key,
                    );
                  }).toList(),
                ),
                DropdownButton(
                  hint: Text(
                      "Kompatibilita"),
                  value: wheel
                      .selectedCompatibility,
                  onChanged: (newValue) {
                    setState(() {
                      wheel.selectedCompatibility =
                          newValue;
                    });
                  },
                  items: Wheel
                      .compatibility
                      .asMap()
                      .entries
                      .map((entry) {
                    return DropdownMenuItem(
                      child: new Text(
                          entry.value),
                      value: entry.key,
                    );
                  }).toList(),
                ),
              ],
            );
- - KLIKY
            return Column(children: [
              DropdownButton(
                hint: Text("Značka"),
                value:
                    cranks.selectedBrand,
                onChanged: (newValue) {
                  setState(() {
                    cranks.selectedBrand =
                        newValue;
                  });
                },
                items: Cranks.brand
                    .asMap()
                    .entries
                    .map((entry) {
                  return DropdownMenuItem(
                    child: new Text(
                        entry.value),
                    value: entry.key,
                  );
                }).toList(),
              ),
              DropdownButton(
                hint:
                    Text("Kompatibilita"),
                value: cranks
                    .selectedCompatibility,
                onChanged: (newValue) {
                  setState(() {
                    cranks.selectedCompatibility =
                        newValue;
                  });
                },
                items: Cranks
                    .compatibility
                    .asMap()
                    .entries
                    .map((entry) {
                  return DropdownMenuItem(
                    child: new Text(
                        entry.value),
                    value: entry.key,
                  );
                }).toList(),
              ),
              DropdownButton(
                hint: Text("Materiál"),
                value: cranks
                    .selectedMaterial,
                onChanged: (newValue) {
                  setState(() {
                    cranks.selectedMaterial =
                        newValue;
                  });
                },
                items: Cranks.material
                    .asMap()
                    .entries
                    .map((entry) {
                  return DropdownMenuItem(
                    child: new Text(
                        entry.value),
                    value: entry.key,
                  );
                }).toList(),
              ),
              DropdownButton(
                hint: Text("Osa"),
                value:
                    cranks.selectedAxis,
                onChanged: (newValue) {
                  setState(() {
                    cranks.selectedAxis =
                        newValue;
                  });
                },
                items: Cranks.axis
                    .asMap()
                    .entries
                    .map((entry) {
                  return DropdownMenuItem(
                    child: new Text(
                        entry.value),
                    value: entry.key,
                  );
                }).toList(),
              ),
            ]);
- - PŘEVODNÍK
            return Column(
              children: [
                DropdownButton(
                  hint: Text("Značka"),
                  value: converter
                      .selectedBrand,
                  onChanged: (newValue) {
                    setState(() {
                      converter
                              .selectedBrand =
                          newValue;
                    });
                  },
                  items: Converter.brand
                      .asMap()
                      .entries
                      .map((entry) {
                    return DropdownMenuItem(
                      child: new Text(
                          entry.value),
                      value: entry.key,
                    );
                  }).toList(),
                ),
                DropdownButton(
                  hint: Text(
                      "Počet rychlostí"),
                  value: converter
                      .selectedNumOfSpeeds,
                  onChanged: (newValue) {
                    setState(() {
                      converter
                              .selectedNumOfSpeeds =
                          newValue;
                    });
                  },
                  items: Converter
                      .numOfSpeeds
                      .asMap()
                      .entries
                      .map((entry) {
                    return DropdownMenuItem(
                      child: new Text(
                          entry.value),
                      value: entry.key,
                    );
                  }).toList(),
                ),
              ],
            );
- - SEDLO
            return Column(children: [
              DropdownButton(
                hint: Text("Značka"),
                value:
                    saddle.selectedBrand,
                onChanged: (newValue) {
                  setState(() {
                    saddle.selectedBrand =
                        newValue;
                  });
                },
                items: Saddle.brand
                    .asMap()
                    .entries
                    .map((entry) {
                  return DropdownMenuItem(
                    child: new Text(
                        entry.value),
                    value: entry.key,
                  );
                }).toList(),
              ),
              DropdownButton(
                hint: Text("Pohlaví"),
                value:
                    saddle.selectedGender,
                onChanged: (newValue) {
                  setState(() {
                    saddle.selectedGender =
                        newValue;
                  });
                },
                items: Saddle.gender
                    .asMap()
                    .entries
                    .map((entry) {
                  return DropdownMenuItem(
                    child: new Text(
                        entry.value),
                    value: entry.key,
                  );
                }).toList(),
              ),
            ]);
- - VIDLICE
            Column(
              children: [
                DropdownButton(
                  hint: Text("Značka"),
                  value:
                      fork.selectedBrand,
                  onChanged: (newValue) {
                    setState(() {
                      fork.selectedBrand =
                          newValue;
                    });
                  },
                  items: Fork.brand
                      .asMap()
                      .entries
                      .map((entry) {
                    return DropdownMenuItem(
                      child: new Text(
                          entry.value),
                      value: entry.key,
                    );
                  }).toList(),
                ),
                DropdownButton(
                  hint: Text("Velikost"),
                  value:
                      fork.selectedSize,
                  onChanged: (newValue) {
                    setState(() {
                      fork.selectedSize =
                          newValue;
                    });
                  },
                  items: Fork.size
                      .asMap()
                      .entries
                      .map((entry) {
                    return DropdownMenuItem(
                      child: new Text(
                          entry.value),
                      value: entry.key,
                    );
                  }).toList(),
                ),
                Row(children: [
                  Text(
                      "Typ vidlice: Odpružená "),
                  Switch(
                    value: fork
                        .selectedSuspension,
                    onChanged: (value) {
                      setState(() {
                        fork.selectedSuspension =
                            value;
                      });
                    },
                  ),
                  Text(" Pevná")
                ]),
                Row(children: [
                  Text(
                      "Odpružení: Vzduchové "),
                  Switch(
                    value: fork
                        .selectedSuspensionType,
                    onChanged: (value) {
                      setState(() {
                        fork.selectedSuspensionType =
                            value;
                      });
                    },
                  ),
                  Text(" Pružinové")
                ]),
                DropdownButton(
                  hint: Text(
                      "Kompatibilita"),
                  value: fork
                      .selectedWheelCoompatibility,
                  onChanged: (newValue) {
                    setState(() {
                      fork.selectedWheelCoompatibility =
                          newValue;
                    });
                  },
                  items: Fork
                      .wheelCompatibility
                      .asMap()
                      .entries
                      .map((entry) {
                    return DropdownMenuItem(
                      child: new Text(
                          entry.value),
                      value: entry.key,
                    );
                  }).toList(),
                ),
                DropdownButton(
                  hint: Text("Materiál"),
                  value: fork
                      .selectedMaterial,
                  onChanged: (newValue) {
                    setState(() {
                      fork.selectedMaterial =
                          newValue;
                    });
                  },
                  items: Fork.material
                      .asMap()
                      .entries
                      .map((entry) {
                    return DropdownMenuItem(
                      child: new Text(
                          entry.value),
                      value: entry.key,
                    );
                  }).toList(),
                ),
                DropdownButton(
                  hint: Text(
                      "Materiál sloupku"),
                  value: fork
                      .selectedMaterialColumn,
                  onChanged: (newValue) {
                    setState(() {
                      fork.selectedMaterialColumn =
                          newValue;
                    });
                  },
                  items: Fork
                      .materialColumn
                      .asMap()
                      .entries
                      .map((entry) {
                    return DropdownMenuItem(
                      child: new Text(
                          entry.value),
                      value: entry.key,
                    );
                  }).toList(),
                ),
              ],
            );

- DOPLNĚK
  return DropdownButton(
    hint: Text("Doplněk"),
    value: category.selectedAccessory,
    onChanged: (newValue) {
      setState(() {
        category.selectedAccessory =
            newValue;
      });
    },
    items: Category.accessories
        .asMap()
        .entries
        .map((entry) {
      return DropdownMenuItem(
        child: new Text(entry.value),
        value: entry.key,
      );
    }).toList(),
  );

- JINÉ
  return Column(children: [
    DropdownButton(
      hint: Text("Jiné"),
      value: category.selectedOther,
      onChanged: (newValue) {
        setState(() {
          category.selectedOther =
              newValue;
        });
      },
      items: Category.other
          .asMap()
          .entries
          .map((entry) {
        return DropdownMenuItem(
          child: new Text(entry.value),
          value: entry.key,
        );
      }).toList(),
    ),

- - EBIKE
            return Column(
              children: [
                DropdownButton(
                  hint: Text("Značka"),
                  value:
                      eBike.selectedBrand,
                  onChanged: (newValue) {
                    setState(() {
                      eBike.selectedBrand =
                          newValue;
                    });
                  },
                  items: EBike.brand
                      .asMap()
                      .entries
                      .map((entry) {
                    return DropdownMenuItem(
                      child: new Text(
                          entry.value),
                      value: entry.key,
                    );
                  }).toList(),
                ),
                Row(children: [
                  Text(
                      "Umístění motoru: Středový "),
                  Switch(
                    value: eBike
                        .selectedMotorPos,
                    onChanged: (value) {
                      setState(() {
                        eBike.selectedMotorPos =
                            value;
                      });
                    },
                  ),
                  Text(" Nábojový")
                ]),
              ],
            );
- - TRAINER
            return Column(children: [
              DropdownButton(
                hint: Text("Značka"),
                value:
                    trainer.selectedBrand,
                onChanged: (newValue) {
                  setState(() {
                    trainer.selectedBrand =
                        newValue;
                  });
                },
                items: Trainer.brand
                    .asMap()
                    .entries
                    .map((entry) {
                  return DropdownMenuItem(
                    child: new Text(
                        entry.value),
                    value: entry.key,
                  );
                }).toList(),
              ),
              DropdownButton(
                hint: Text("Typ brždění"),
                value: trainer
                    .selectedBrakes,
                onChanged: (newValue) {
                  setState(() {
                    trainer.selectedBrakes =
                        newValue;
                  });
                },
                items: Trainer.brakes
                    .asMap()
                    .entries
                    .map((entry) {
                  return DropdownMenuItem(
                    child: new Text(
                        entry.value),
                    value: entry.key,
                  );
                }).toList(),
              )
            ]);
- - SCOOTER
            return Column(children: [
              DropdownButton(
                hint: Text("Značka"),
                value:
                    scooter.selectedBrand,
                onChanged: (newValue) {
                  setState(() {
                    scooter.selectedBrand =
                        newValue;
                  });
                },
                items: Scooter.brand
                    .asMap()
                    .entries
                    .map((entry) {
                  return DropdownMenuItem(
                    child: new Text(
                        entry.value),
                    value: entry.key,
                  );
                }).toList(),
              ),
              DropdownButton(
                hint: Text(
                    "Velikost koleček"),
                value:
                    scooter.selectedSize,
                onChanged: (newValue) {
                  setState(() {
                    scooter.selectedSize =
                        newValue;
                  });
                },
                items: Scooter.size
                    .asMap()
                    .entries
                    .map((entry) {
                  return DropdownMenuItem(
                    child: new Text(
                        entry.value),
                    value: entry.key,
                  );
                }).toList(),
              ),
              Row(children: [
                Text("Počítač: Ne "),
                Switch(
                  value: scooter
                      .selectedComputer,
                  onChanged: (value) {
                    setState(() {
                      scooter.selectedComputer =
                          value;
                    });
                  },
                ),
                Text(" Ano")
              ])
            ]);