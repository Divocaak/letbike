import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:letbike/app/homePage.dart';
import '../general/general.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPage createState() => _FilterPage();

  static const routeName = "/filterPage";
}

Future<String> addResponse;

class _FilterPage extends State<FilterPage> with TickerProviderStateMixin {
  HomeArguments homeArgs;

  double volume = 0;

  AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    animationController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  bool used = false;
  Category category = Category(null, null, null, null);
  Bike bike = Bike(null, null);

  Cranks cranks = Cranks(null, null, null, null);
  Converter converter = Converter(null, null);
  Saddle saddle = Saddle(null, null);
  Fork fork = Fork(null, null, false, false, null, null, null);
  Wheel wheel = Wheel(
      null, null, null, false, false, null, false, false, false, null, null);

  EBike eBike = EBike(null, false);
  Trainer trainer = Trainer(null, null);
  Scooter scooter = Scooter(null, null, false);

  @override
  Widget build(BuildContext context) {
    homeArgs = ModalRoute.of(context).settings.arguments;

    return MaterialApp(
      title: 'Filtry',
      home: Scaffold(
        body: Stack(
          children: [
            BackgroundImage(),
            Scaffold(
              resizeToAvoidBottomInset: false,
              body: Container(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: ListView(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(children: [
                            Text("Použité: Ne "),
                            Switch(
                              value: used,
                              onChanged: (value) {
                                setState(() {
                                  used = value;
                                });
                              },
                            ),
                            Text(" Ano")
                          ])),
                      Container(
                        height: 20,
                      ),
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              DropdownButton(
                                hint: Text("Kategorie"),
                                value: category.selectedCategory,
                                onChanged: (newValue) {
                                  setState(() {
                                    category.selectedCategory = newValue;
                                  });
                                },
                                items: Category.categories
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  return DropdownMenuItem(
                                    child: new Text(entry.value),
                                    value: entry.key,
                                  );
                                }).toList(),
                              ),
                              Builder(
                                builder: (context) {
                                  switch (category.selectedCategory) {
                                    case 0:
                                      {
                                        return Column(
                                          children: [
                                            DropdownButton(
                                              hint: Text("Značka kola"),
                                              value: bike.selectedBrand,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  bike.selectedBrand = newValue;
                                                });
                                              },
                                              items: Bike.brand
                                                  .asMap()
                                                  .entries
                                                  .map((entry) {
                                                return DropdownMenuItem(
                                                  child: new Text(entry.value),
                                                  value: entry.key,
                                                );
                                              }).toList(),
                                            ),
                                            DropdownButton(
                                              hint: Text("Typ kola"),
                                              value: bike.selectedType,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  bike.selectedType = newValue;
                                                });
                                              },
                                              items: Bike.type
                                                  .asMap()
                                                  .entries
                                                  .map((entry) {
                                                return DropdownMenuItem(
                                                  child: new Text(entry.value),
                                                  value: entry.key,
                                                );
                                              }).toList(),
                                            ),
                                          ],
                                        );
                                      }
                                      break;
                                    case 1:
                                      {
                                        return Column(children: [
                                          DropdownButton(
                                            hint: Text("Typ komponentu"),
                                            value: category.selectedPart,
                                            onChanged: (newValue) {
                                              setState(() {
                                                category.selectedPart =
                                                    newValue;
                                              });
                                            },
                                            items: Category.parts
                                                .asMap()
                                                .entries
                                                .map((entry) {
                                              return DropdownMenuItem(
                                                child: new Text(entry.value),
                                                value: entry.key,
                                              );
                                            }).toList(),
                                          ),
                                          Builder(builder: (context) {
                                            switch (category.selectedPart) {
                                              case 0:
                                                {
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
                                                }
                                                break;
                                              case 1:
                                                {
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
                                                }
                                                break;
                                              case 2:
                                                {
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
                                                }
                                                break;
                                              case 3:
                                                {
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
                                                }
                                                break;
                                              case 4:
                                                {
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
                                                }
                                                break;
                                            }
                                            return Text("");
                                          })
                                        ]);
                                      }
                                      break;
                                    case 2:
                                      {
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
                                      }
                                      break;
                                    case 3:
                                      {
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
                                          Builder(builder: (context) {
                                            switch (category.selectedOther) {
                                              case 0:
                                                {
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
                                                }
                                                break;
                                              case 1:
                                                {
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
                                                }
                                                break;
                                              case 2:
                                                {
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
                                                }
                                                break;
                                            }
                                            return Text("");
                                          })
                                        ]);
                                      }
                                      break;
                                  }
                                  return Text("");
                                },
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
            IgnorePointer(
              ignoring: volume == 0 ? true : false,
              child: Container(
                color: Colors.black.withOpacity(volume),
                child: Stack(
                  children: [
                    Positioned(
                        bottom: 120,
                        right: 120,
                        child: CircularButton(
                            kSecondaryColor.withOpacity(volume * 2),
                            45,
                            Icons.arrow_back,
                            kWhite.withOpacity(volume * 2), () {
                          Navigator.of(context).pushReplacementNamed(
                              HomePage.routeName,
                              arguments: homeArgs);
                        })),
                    Positioned(
                        bottom: 150,
                        right: 40,
                        child: CircularButton(
                            kSecondaryColor.withOpacity(volume * 2),
                            45,
                            Icons.filter_alt,
                            kWhite.withOpacity(volume * 2), () {
                          Navigator.of(context).pushReplacementNamed(
                              HomePage.routeName,
                              arguments: getArguments());
                        })),
                  ],
                ),
              ),
            ),
            Positioned(
                height: 275,
                width: 275,
                right: -75,
                bottom: -75,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    CircularButton(kPrimaryColor, 60, Icons.menu, kWhite, () {
                      if (animationController.isCompleted) {
                        animationController.reverse();
                        volume = 0;
                      } else {
                        animationController.forward();
                        volume = 0.5;
                      }
                    })
                  ],
                ))
          ],
        ),
      ),
    );
  }

  HomeArguments getArguments() {
    return new HomeArguments(
        homeArgs.user,
        new ItemParams({
          "used": used ? 1 : 0,
          "selectedCategory": category.selectedCategory != null
              ? category.selectedCategory
              : -1,
          "selectedParts":
              category.selectedPart != null ? category.selectedPart : -1,
          "selectedAccessories": category.selectedAccessory != null
              ? category.selectedAccessory
              : -1,
          "selectedOther":
              category.selectedOther != null ? category.selectedOther : -1,
          "bikeType": bike.selectedType != null ? bike.selectedType : -1,
          "bikeBrand": bike.selectedBrand != null ? bike.selectedBrand : -1,
          "wheelBrand": wheel.selectedBrand != null ? wheel.selectedBrand : -1,
          "wheelSize": wheel.selectedSize != null ? wheel.selectedSize : -1,
          "wheelMaterial":
              wheel.selectedMaterial != null ? wheel.selectedMaterial : -1,
          "wheeldSpokes": ((wheel.selectedSpokes ? 1 : 0) +
              (category.selectedPart != null ? category.selectedPart : 0) +
              (category.selectedOther != null ? category.selectedOther : 0) +
              999),
          "wheeldType": ((wheel.selectedType ? 1 : 0) +
              (category.selectedPart != null ? category.selectedPart : 0) +
              (category.selectedOther != null ? category.selectedOther : 0) +
              999),
          "wheelAxis": wheel.selectedAxis != null ? wheel.selectedAxis : -1,
          "wheeldBrakesType": ((wheel.selectedBrakesType ? 1 : 0) +
              (category.selectedPart != null ? category.selectedPart : 0) +
              (category.selectedOther != null ? category.selectedOther : 0) +
              999),
          "wheeldBrakesDisc": ((wheel.selectedBrakesDisc ? 1 : 0) +
              (category.selectedPart != null ? category.selectedPart : 0) +
              (category.selectedOther != null ? category.selectedOther : 0) +
              999),
          "wheeldCassette": ((wheel.selectedCassette ? 1 : 0) +
              (category.selectedPart != null ? category.selectedPart : 0) +
              (category.selectedOther != null ? category.selectedOther : 0) +
              999),
          "wheelNut": wheel.selectedNut != null ? wheel.selectedNut : -1,
          "wheelCompatibility": wheel.selectedCompatibility != null
              ? wheel.selectedCompatibility
              : -1,
          "cranksBrand":
              cranks.selectedBrand != null ? cranks.selectedBrand : -1,
          "cranksCompatibility": cranks.selectedCompatibility != null
              ? cranks.selectedCompatibility
              : -1,
          "cranksMaterial":
              cranks.selectedMaterial != null ? cranks.selectedMaterial : -1,
          "cranksAxis": cranks.selectedAxis != null ? cranks.selectedAxis : -1,
          "converterBrand":
              converter.selectedBrand != null ? converter.selectedBrand : -1,
          "converterNumOfSpeeds": converter.selectedNumOfSpeeds != null
              ? converter.selectedNumOfSpeeds
              : -1,
          "saddleBrand":
              saddle.selectedBrand != null ? saddle.selectedBrand : -1,
          "saddleGender":
              saddle.selectedGender != null ? saddle.selectedGender : -1,
          "forkBrand": fork.selectedBrand != null ? fork.selectedBrand : -1,
          "forkSize": fork.selectedSize != null ? fork.selectedSize : -1,
          "forkSuspensionType": ((fork.selectedSuspensionType ? 1 : 0) +
              (category.selectedPart != null ? category.selectedPart : 0) +
              (category.selectedOther != null ? category.selectedOther : 0) +
              999),
          "forkSuspension": ((fork.selectedSuspension ? 1 : 0) +
              (category.selectedPart != null ? category.selectedPart : 0) +
              (category.selectedOther != null ? category.selectedOther : 0) +
              999),
          "forkWheelCoompatibility": fork.selectedWheelCoompatibility != null
              ? fork.selectedWheelCoompatibility
              : -1,
          "forkMaterial":
              fork.selectedMaterial != null ? fork.selectedMaterial : -1,
          "forkMaterialColumn": fork.selectedMaterialColumn != null
              ? fork.selectedMaterialColumn
              : -1,
          "eBikeBrand": eBike.selectedBrand != null ? eBike.selectedBrand : -1,
          "eBikeMotorPos": ((eBike.selectedMotorPos ? 1 : 0) +
              (category.selectedPart != null ? category.selectedPart : 0) +
              (category.selectedOther != null ? category.selectedOther : 0) +
              999),
          "trainerBrand":
              trainer.selectedBrand != null ? trainer.selectedBrand : -1,
          "trainerBrakes":
              trainer.selectedBrakes != null ? trainer.selectedBrakes : -1,
          "scooterBrand":
              scooter.selectedBrand != null ? scooter.selectedBrand : -1,
          "scooterSize":
              scooter.selectedSize != null ? scooter.selectedSize : -1,
          "scooterComputer": ((scooter.selectedComputer ? 1 : 0) +
              (category.selectedPart != null ? category.selectedPart : 0) +
              (category.selectedOther != null ? category.selectedOther : 0) +
              999),
        }));
  }
}
