import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:letbike/app/homePage.dart';
import '../general/general.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItem createState() => _AddItem();

  static const routeName = "/addItem";
}

Future<String> addResponse;

class _AddItem extends State<AddItem> with TickerProviderStateMixin {
  User user;
  List<Asset> images = [];

  Widget buildGridView() {
    if (images != null)
      return GridView.count(
        crossAxisCount: 3,
        children: List.generate(images.length, (index) {
          Asset asset = images[index];
          return AssetThumb(
            asset: asset,
            width: 300,
            height: 300,
          );
        }),
      );
    else
      return Container(color: Colors.white);
  }

  Future<int> checkPerm() async {
    var status = await Permission.camera.status;
    if (status != PermissionStatus.granted) {
      await Permission.camera.request();
      return Permission.camera.value;
    } else {
      return 1;
    }
  }

  Future<void> loadAssets() async {
    setState(() {
      images = [];
    });

    List<Asset> resultList;
    String error;

    if (await checkPerm() == 1) {
      try {
        resultList = await MultiImagePicker.pickImages(
          maxImages: 10,
          enableCamera: true,
        );
      } on Exception catch (e) {
        error = e.toString();
      }
      if (!mounted) return;

      setState(() {
        images = resultList;
        if (error != null)
          AlertBox.showAlertBox(context, "Error", Text("Error"));
      });
    }
  }

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
    user = ModalRoute.of(context).settings.arguments;

    return MaterialApp(
      title: 'Přidat předmět',
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
                      TextInput(
                        icon: Icons.text_fields,
                        hint: "Název předmětu",
                        identificator: "addName",
                        inputAction: TextInputAction.next,
                      ),
                      TextInput(
                        icon: Icons.text_fields,
                        hint: "Popis předmětu",
                        identificator: "addDesc",
                        inputAction: TextInputAction.next,
                      ),
                      TextInput(
                        icon: Icons.attach_money,
                        hint: "Cena",
                        identificator: "addPric",
                        inputAction: TextInputAction.done,
                        inputType: TextInputType.number,
                      ),
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
                              Padding(
                                padding: EdgeInsets.all(7.0),
                                child: Text(
                                    "Následující parametry jsou volitelné, avšak zvyšují šanci prodeje."),
                              ),
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
                      Container(height: 20),
                      Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Column(
                            children: [
                              Container(
                                child: TextButton(
                                  child: Text("Vybrat foto z úložiště"),
                                  onPressed: loadAssets,
                                ),
                              ),
                              Expanded(
                                child: buildGridView(),
                              )
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
                              arguments: user);
                        })),
                    Positioned(
                        bottom: 150,
                        right: 40,
                        child: CircularButton(
                            kSecondaryColor.withOpacity(volume * 2),
                            45,
                            Icons.add,
                            kWhite.withOpacity(volume * 2), () {
                          addResponse = DatabaseServices.createItem(
                              new Item(
                                  -1,
                                  user.id,
                                  TextInput.getValue("addName"),
                                  TextInput.getValue("addDesc"),
                                  double.parse(TextInput.getValue("addPric")),
                                  0,
                                  0,
                                  "",
                                  "",
                                  "",
                                  0,
                                  new ItemParams({
                                    "used": used ? 1 : 0,
                                    "selectedCategory":
                                        category.selectedCategory,
                                    "selectedParts": category.selectedPart,
                                    "selectedAccessories":
                                        category.selectedAccessory,
                                    "selectedOther": category.selectedOther,
                                    "bikeType": bike.selectedType,
                                    "bikeBrand": bike.selectedBrand,
                                    "wheelBrand": wheel.selectedBrand,
                                    "wheelSize": wheel.selectedSize,
                                    "wheelMaterial": wheel.selectedMaterial,
                                    "wheeldSpokes":
                                        ((wheel.selectedSpokes ? 1 : 0) +
                                            (category.selectedPart != null
                                                ? category.selectedPart
                                                : 0) +
                                            (category.selectedOther != null
                                                ? category.selectedOther
                                                : 0) +
                                            999),
                                    "wheeldType":
                                        ((wheel.selectedType ? 1 : 0) +
                                            (category.selectedPart != null
                                                ? category.selectedPart
                                                : 0) +
                                            (category.selectedOther != null
                                                ? category.selectedOther
                                                : 0) +
                                            999),
                                    "wheelAxis": wheel.selectedAxis,
                                    "wheeldBrakesType":
                                        ((wheel.selectedBrakesType ? 1 : 0) +
                                            (category.selectedPart != null
                                                ? category.selectedPart
                                                : 0) +
                                            (category.selectedOther != null
                                                ? category.selectedOther
                                                : 0) +
                                            999),
                                    "wheeldBrakesDisc":
                                        ((wheel.selectedBrakesDisc ? 1 : 0) +
                                            (category.selectedPart != null
                                                ? category.selectedPart
                                                : 0) +
                                            (category.selectedOther != null
                                                ? category.selectedOther
                                                : 0) +
                                            999),
                                    "wheeldCassette":
                                        ((wheel.selectedCassette ? 1 : 0) +
                                            (category.selectedPart != null
                                                ? category.selectedPart
                                                : 0) +
                                            (category.selectedOther != null
                                                ? category.selectedOther
                                                : 0) +
                                            999),
                                    "wheelNut": wheel.selectedNut,
                                    "wheelCompatibility":
                                        wheel.selectedCompatibility,
                                    "cranksBrand": cranks.selectedBrand,
                                    "cranksCompatibility":
                                        cranks.selectedCompatibility,
                                    "cranksMaterial": cranks.selectedMaterial,
                                    "cranksAxis": cranks.selectedAxis,
                                    "converterBrand": converter.selectedBrand,
                                    "converterNumOfSpeeds":
                                        converter.selectedNumOfSpeeds,
                                    "saddleBrand": saddle.selectedBrand,
                                    "saddleGender": saddle.selectedGender,
                                    "forkBrand": fork.selectedBrand,
                                    "forkSize": fork.selectedSize,
                                    "forkSuspensionType":
                                        ((fork.selectedSuspensionType ? 1 : 0) +
                                            (category.selectedPart != null
                                                ? category.selectedPart
                                                : 0) +
                                            (category.selectedOther != null
                                                ? category.selectedOther
                                                : 0) +
                                            999),
                                    "forkSuspension":
                                        ((fork.selectedSuspension ? 1 : 0) +
                                            (category.selectedPart != null
                                                ? category.selectedPart
                                                : 0) +
                                            (category.selectedOther != null
                                                ? category.selectedOther
                                                : 0) +
                                            999),
                                    "forkWheelCoompatibility":
                                        fork.selectedWheelCoompatibility,
                                    "forkMaterial": fork.selectedMaterial,
                                    "forkMaterialColumn":
                                        fork.selectedMaterialColumn,
                                    "eBikeBrand": eBike.selectedBrand,
                                    "eBikeMotorPos":
                                        ((eBike.selectedMotorPos ? 1 : 0) +
                                            (category.selectedPart != null
                                                ? category.selectedPart
                                                : 0) +
                                            (category.selectedOther != null
                                                ? category.selectedOther
                                                : 0) +
                                            999),
                                    "trainerBrand": trainer.selectedBrand,
                                    "trainerBrakes": trainer.selectedBrakes,
                                    "scooterBrand": scooter.selectedBrand,
                                    "scooterSize": scooter.selectedSize,
                                    "scooterComputer":
                                        ((scooter.selectedComputer ? 1 : 0) +
                                            (category.selectedPart != null
                                                ? category.selectedPart
                                                : 0) +
                                            (category.selectedOther != null
                                                ? category.selectedOther
                                                : 0) +
                                            999),
                                  })),
                              images);

                          AlertBox.showAlertBox(
                              context,
                              "Oznámení",
                              FutureBuilder<String>(
                                future: addResponse,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(snapshot.data);
                                  } else if (snapshot.hasError) {
                                    return Text('Sorry there is an error');
                                  }
                                  return Center(
                                      child: CircularProgressIndicator());
                                },
                              ));
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
}
