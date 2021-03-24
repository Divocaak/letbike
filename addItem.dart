import 'dart:convert';

import 'package:flutter/material.dart';
import 'itemClasses.dart';

void main() => runApp(AddItem());

class AddItem extends StatefulWidget {
  @override
  _AddItem createState() => _AddItem();
}

class _AddItem extends State<AddItem> {
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
    return MaterialApp(
        title: 'Přidat inzerát',
        home: Scaffold(
          body: Column(children: [
            Row(children: <Widget>[
              Text("Použité: "),
              Switch(
                value: used,
                onChanged: (value) {
                  setState(() {
                    used = value;
                    print(used);
                  });
                },
              ),
            ]),
            TextField(
              obscureText: false,
              maxLength: 50,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Název inzerátu"),
            ),
            TextField(
              obscureText: false,
              maxLength: 255,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Popis předmětu"),
            ),
            TextField(
              obscureText: false,
              maxLength: null,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Cena"),
            ),
            Text(
                "Následující parametry jsou volitelné, avšak zvyšují šanci prodeje."),
            DropdownButton(
              hint: Text("Kategorie"),
              value: category.selectedCategory,
              onChanged: (newValue) {
                setState(() {
                  category.selectedCategory = newValue;
                });
              },
              items: Category.categories.asMap().entries.map((entry) {
                return DropdownMenuItem(
                  child: new Text(entry.value),
                  value: entry.key,
                );
              }).toList(),
            ),
            Builder(builder: (context) {
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
                          items: Bike.brand.asMap().entries.map((entry) {
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
                          items: Bike.type.asMap().entries.map((entry) {
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
                            category.selectedPart = newValue;
                          });
                        },
                        items: Category.parts.asMap().entries.map((entry) {
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
                                    value: wheel.selectedBrand,
                                    onChanged: (newValue) {
                                      setState(() {
                                        wheel.selectedBrand = newValue;
                                      });
                                    },
                                    items: Wheel.brand
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
                                    hint: Text("Velikost"),
                                    value: wheel.selectedSize,
                                    onChanged: (newValue) {
                                      setState(() {
                                        wheel.selectedSize = newValue;
                                      });
                                    },
                                    items:
                                        Wheel.size.asMap().entries.map((entry) {
                                      return DropdownMenuItem(
                                        child: new Text(entry.value),
                                        value: entry.key,
                                      );
                                    }).toList(),
                                  ),
                                  DropdownButton(
                                    hint: Text("Materiál"),
                                    value: wheel.selectedMaterial,
                                    onChanged: (newValue) {
                                      setState(() {
                                        wheel.selectedMaterial = newValue;
                                      });
                                    },
                                    items: Wheel.material
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      return DropdownMenuItem(
                                        child: new Text(entry.value),
                                        value: entry.key,
                                      );
                                    }).toList(),
                                  ),
                                  Row(children: [
                                    Text("Typ drátů: Ploché "),
                                    Switch(
                                      value: wheel.selectedSpokes,
                                      onChanged: (value) {
                                        setState(() {
                                          wheel.selectedSpokes = value;
                                        });
                                      },
                                    ),
                                    Text(" Kulaté")
                                  ]),
                                  Row(children: [
                                    Text("Provedení náboje: Přední "),
                                    Switch(
                                      value: wheel.selectedType,
                                      onChanged: (value) {
                                        setState(() {
                                          wheel.selectedType = value;
                                        });
                                      },
                                    ),
                                    Text(" Zadní")
                                  ]),
                                  DropdownButton(
                                    hint: Text("Provedení osy"),
                                    value: wheel.selectedAxis,
                                    onChanged: (newValue) {
                                      setState(() {
                                        wheel.selectedAxis = newValue;
                                      });
                                    },
                                    items:
                                        Wheel.axis.asMap().entries.map((entry) {
                                      return DropdownMenuItem(
                                        child: new Text(entry.value),
                                        value: entry.key,
                                      );
                                    }).toList(),
                                  ),
                                  Row(children: [
                                    Text("Typ brzd: Kotoučové "),
                                    Switch(
                                      value: wheel.selectedBrakesType,
                                      onChanged: (value) {
                                        setState(() {
                                          wheel.selectedBrakesType = value;
                                        });
                                      },
                                    ),
                                    Text(" V-Brzdy")
                                  ]),
                                  Row(children: [
                                    Text("Uchycení disku: CenterLock "),
                                    Switch(
                                      value: wheel.selectedBrakesDisc,
                                      onChanged: (value) {
                                        setState(() {
                                          wheel.selectedBrakesDisc = value;
                                        });
                                      },
                                    ),
                                    Text(" 6 děr")
                                  ]),
                                  Row(children: [
                                    Text(
                                        "Provedení kazety: Závit (šroubovací kolečko) "),
                                    Switch(
                                      value: wheel.selectedCassette,
                                      onChanged: (value) {
                                        setState(() {
                                          wheel.selectedCassette = value;
                                        });
                                      },
                                    ),
                                    Text(" Ořech")
                                  ]),
                                  DropdownButton(
                                    hint: Text("Značka ořechu"),
                                    value: wheel.selectedNut,
                                    onChanged: (newValue) {
                                      setState(() {
                                        wheel.selectedNut = newValue;
                                      });
                                    },
                                    items:
                                        Wheel.nut.asMap().entries.map((entry) {
                                      return DropdownMenuItem(
                                        child: new Text(entry.value),
                                        value: entry.key,
                                      );
                                    }).toList(),
                                  ),
                                  DropdownButton(
                                    hint: Text("Kompatibilita"),
                                    value: wheel.selectedCompatibility,
                                    onChanged: (newValue) {
                                      setState(() {
                                        wheel.selectedCompatibility = newValue;
                                      });
                                    },
                                    items: Wheel.compatibility
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
                                  hint: Text("Značka"),
                                  value: cranks.selectedBrand,
                                  onChanged: (newValue) {
                                    setState(() {
                                      cranks.selectedBrand = newValue;
                                    });
                                  },
                                  items:
                                      Cranks.brand.asMap().entries.map((entry) {
                                    return DropdownMenuItem(
                                      child: new Text(entry.value),
                                      value: entry.key,
                                    );
                                  }).toList(),
                                ),
                                DropdownButton(
                                  hint: Text("Kompatibilita"),
                                  value: cranks.selectedCompatibility,
                                  onChanged: (newValue) {
                                    setState(() {
                                      cranks.selectedCompatibility = newValue;
                                    });
                                  },
                                  items: Cranks.compatibility
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
                                  hint: Text("Materiál"),
                                  value: cranks.selectedMaterial,
                                  onChanged: (newValue) {
                                    setState(() {
                                      cranks.selectedMaterial = newValue;
                                    });
                                  },
                                  items: Cranks.material
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
                                  hint: Text("Osa"),
                                  value: cranks.selectedAxis,
                                  onChanged: (newValue) {
                                    setState(() {
                                      cranks.selectedAxis = newValue;
                                    });
                                  },
                                  items:
                                      Cranks.axis.asMap().entries.map((entry) {
                                    return DropdownMenuItem(
                                      child: new Text(entry.value),
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
                                    value: converter.selectedBrand,
                                    onChanged: (newValue) {
                                      setState(() {
                                        converter.selectedBrand = newValue;
                                      });
                                    },
                                    items: Converter.brand
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
                                    hint: Text("Počet rychlostí"),
                                    value: converter.selectedNumOfSpeeds,
                                    onChanged: (newValue) {
                                      setState(() {
                                        converter.selectedNumOfSpeeds =
                                            newValue;
                                      });
                                    },
                                    items: Converter.numOfSpeeds
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
                          case 3:
                            {
                              return Column(children: [
                                DropdownButton(
                                  hint: Text("Značka"),
                                  value: saddle.selectedBrand,
                                  onChanged: (newValue) {
                                    setState(() {
                                      saddle.selectedBrand = newValue;
                                    });
                                  },
                                  items:
                                      Saddle.brand.asMap().entries.map((entry) {
                                    return DropdownMenuItem(
                                      child: new Text(entry.value),
                                      value: entry.key,
                                    );
                                  }).toList(),
                                ),
                                DropdownButton(
                                  hint: Text("Pohlaví"),
                                  value: saddle.selectedGender,
                                  onChanged: (newValue) {
                                    setState(() {
                                      saddle.selectedGender = newValue;
                                    });
                                  },
                                  items: Saddle.gender
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    return DropdownMenuItem(
                                      child: new Text(entry.value),
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
                                    value: fork.selectedBrand,
                                    onChanged: (newValue) {
                                      setState(() {
                                        fork.selectedBrand = newValue;
                                      });
                                    },
                                    items:
                                        Fork.brand.asMap().entries.map((entry) {
                                      return DropdownMenuItem(
                                        child: new Text(entry.value),
                                        value: entry.key,
                                      );
                                    }).toList(),
                                  ),
                                  DropdownButton(
                                    hint: Text("Velikost"),
                                    value: fork.selectedSize,
                                    onChanged: (newValue) {
                                      setState(() {
                                        fork.selectedSize = newValue;
                                      });
                                    },
                                    items:
                                        Fork.size.asMap().entries.map((entry) {
                                      return DropdownMenuItem(
                                        child: new Text(entry.value),
                                        value: entry.key,
                                      );
                                    }).toList(),
                                  ),
                                  Row(children: [
                                    Text("Typ vidlice: Odpružená "),
                                    Switch(
                                      value: fork.selectedSuspension,
                                      onChanged: (value) {
                                        setState(() {
                                          fork.selectedSuspension = value;
                                        });
                                      },
                                    ),
                                    Text(" Pevná")
                                  ]),
                                  Row(children: [
                                    Text("Odpružení: Vzduchové "),
                                    Switch(
                                      value: fork.selectedSuspensionType,
                                      onChanged: (value) {
                                        setState(() {
                                          fork.selectedSuspensionType = value;
                                        });
                                      },
                                    ),
                                    Text(" Pružinové")
                                  ]),
                                  DropdownButton(
                                    hint: Text("Kompatibilita"),
                                    value: fork.selectedWheelCoompatibility,
                                    onChanged: (newValue) {
                                      setState(() {
                                        fork.selectedWheelCoompatibility =
                                            newValue;
                                      });
                                    },
                                    items: Fork.wheelCompatibility
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
                                    hint: Text("Materiál"),
                                    value: fork.selectedMaterial,
                                    onChanged: (newValue) {
                                      setState(() {
                                        fork.selectedMaterial = newValue;
                                      });
                                    },
                                    items: Fork.material
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
                                    hint: Text("Materiál sloupku"),
                                    value: fork.selectedMaterialColumn,
                                    onChanged: (newValue) {
                                      setState(() {
                                        fork.selectedMaterialColumn = newValue;
                                      });
                                    },
                                    items: Fork.materialColumn
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
                          category.selectedAccessory = newValue;
                        });
                      },
                      items: Category.accessories.asMap().entries.map((entry) {
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
                            category.selectedOther = newValue;
                          });
                        },
                        items: Category.other.asMap().entries.map((entry) {
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
                                    value: eBike.selectedBrand,
                                    onChanged: (newValue) {
                                      setState(() {
                                        eBike.selectedBrand = newValue;
                                      });
                                    },
                                    items: EBike.brand
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      return DropdownMenuItem(
                                        child: new Text(entry.value),
                                        value: entry.key,
                                      );
                                    }).toList(),
                                  ),
                                  Row(children: [
                                    Text("Umístění motoru: Středový "),
                                    Switch(
                                      value: eBike.selectedMotorPos,
                                      onChanged: (value) {
                                        setState(() {
                                          eBike.selectedMotorPos = value;
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
                                  value: trainer.selectedBrand,
                                  onChanged: (newValue) {
                                    setState(() {
                                      trainer.selectedBrand = newValue;
                                    });
                                  },
                                  items: Trainer.brand
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
                                  hint: Text("Typ brždění"),
                                  value: trainer.selectedBrakes,
                                  onChanged: (newValue) {
                                    setState(() {
                                      trainer.selectedBrakes = newValue;
                                    });
                                  },
                                  items: Trainer.brakes
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    return DropdownMenuItem(
                                      child: new Text(entry.value),
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
                                  value: scooter.selectedBrand,
                                  onChanged: (newValue) {
                                    setState(() {
                                      scooter.selectedBrand = newValue;
                                    });
                                  },
                                  items: Scooter.brand
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
                                  hint: Text("Velikost koleček"),
                                  value: scooter.selectedSize,
                                  onChanged: (newValue) {
                                    setState(() {
                                      scooter.selectedSize = newValue;
                                    });
                                  },
                                  items:
                                      Scooter.size.asMap().entries.map((entry) {
                                    return DropdownMenuItem(
                                      child: new Text(entry.value),
                                      value: entry.key,
                                    );
                                  }).toList(),
                                ),
                                Row(children: [
                                  Text("Počítač: Ano "),
                                  Switch(
                                    value: scooter.selectedComputer,
                                    onChanged: (value) {
                                      setState(() {
                                        scooter.selectedComputer = value;
                                      });
                                    },
                                  ),
                                  Text(" Ne")
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
            })
          ]),
        ));
  }
}
/* 
DropdownButton createDropdown(String text, int val, List<String> options) {
  print("asd");
  return DropdownButton(
    hint: Text(text),
    value: val,
    onChanged: (newValue) {
      setState(() {
        val = newValue;
      });
    },
    items: options.asMap().entries.map((entry) {
      return DropdownMenuItem(
        child: new Text(entry.value),
        value: entry.key,
      );
    }).toList(),
  );
} */
