import 'package:flutter/material.dart';
/* import 'dart:async';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
 */
import 'kategorie.dart';
import 'package:flutter/services.dart';
import 'nastaveniKola.dart';
import 'nastaveniKomponenty.dart';
import 'tvorbaInzeratu.dart';
import 'seznamy.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> kategorie;
    List<String> druhKola;

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Aplikace'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.8415,
              child: ListView(children: <Widget>[
                Row(children: <Widget>[
                  Container(
                    child: Switch(
                      value: Kategorie.pouzite,
                      onChanged: (value) {
                        setState(
                          () {
                            Kategorie.pouzite = value;
                          },
                        );
                      },
                    ),
                  ),
                  Text('Použité')
                ]),
                Container(
                    child: ElevatedButton(
                        child: Text('Vytvořit inzerát'),
                        onPressed: () {
                          Navigator.of(context).push(_stranaTvorbaInzeratu());
                        })),
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Kategorie(Seznamy().kategorie),
                ),
              ]),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                child: Text('asd'),
                onPressed: () {
                  print(Kategorie.selectedKategorie);
                  switch (Kategorie.selectedKategorie) {
                    case 'Kola':
                      {
                        Kategorie.vyberKategorie = 'kola';
                        Navigator.of(context).push(_stranaDruhKola());
                        print("kola");
                      }
                      break;
                    case 'Komponenty':
                      {
                        Kategorie.vyberKategorie = 'komponenty';
                        Navigator.of(context).push(_stranaKomponenty());
                      }
                      break;
                    case 'Doplňky':
                      {
                        Kategorie.vyberKategorie = 'doplnky';
                        Navigator.of(context).push(_stranaDoplnky());
                      }
                      break;
                    case 'Ostatní':
                      {
                        Kategorie.vyberKategorie = 'ostatni';
                        Navigator.of(context).push(_stranaOstatni());
                      }
                      break;
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Route _stranaDruhKola() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => StranaDruhKola(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

class StranaDruhKola extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Kategorie.selectedKategorie),
        ),
        body: ListView(children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.84,
            child: Kategorie(Seznamy().druhKola),
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.05,
              child: ElevatedButton(
                child: Text('Další'),
                onPressed: () {
                  if ('Kola' != Kategorie.selectedKategorie) {
                    Kategorie.vyberDruhKola = Kategorie.selectedKategorie;
                    switch (Kategorie.selectedKategorie) {
                      case 'Celoodpružené':
                        {
                          Navigator.of(context).push(_stranaCeloodpruzene());
                        }
                        break;
                      case 'Elektrokola':
                        {
                          Navigator.of(context).push(_stranaElektrokola());
                        }
                        break;
                      case 'Trenažéry':
                        {
                          Navigator.of(context).push(_stranaTrenazery());
                        }
                        break;
                      case 'Koloběžky':
                        {
                          Navigator.of(context).push(_stranaKolobezky());
                        }
                        break;
                      case 'Odrážedla':
                        {
                          Navigator.of(context).push(_stranaOdrazedla());
                        }
                        break;
                      case 'Singlespeed':
                        {
                          Navigator.of(context).push(_stranaSinglespeed());
                        }
                        break;
                      default:
                        {
                          Navigator.of(context).push(_stranaNastaveniKola());
                        }
                    }
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Chyba'),
                            content: Text('Vyberte druh kola'),
                            actions: [
                              TextButton(
                                child: Text('Ok'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        });
                  }
                },
              ))
        ]));
  }
}

Route _stranaCeloodpruzene() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        StranaCeloodpruzene(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

class StranaCeloodpruzene extends StatelessWidget {
  Widget build(BuildContext context) {
    NastaveniKola.celoodpruzene = true;
    NastaveniKola.typ1Vidlice = false;
    return Scaffold(
      appBar: AppBar(
        title: Text(Kategorie.selectedKategorie),
      ),
      body: NastaveniKola(),
    );
  }
}

Route _stranaElektrokola() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        StranaElektrokola(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

class StranaElektrokola extends StatelessWidget {
  Widget build(BuildContext context) {
    NastaveniKola.elektrokolo = true;
    return Scaffold(
      appBar: AppBar(
        title: Text(Kategorie.selectedKategorie),
      ),
      body: NastaveniKola(),
    );
  }
}

Route _stranaTrenazery() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => StranaTrenazery(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

class StranaTrenazery extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Kategorie.selectedKategorie),
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.84,
              child: ListView(
                children: <Widget>[
                  NastaveniKolaTest(true, Seznamy().brzdnySystemTrenazery,
                      'Brzdný systém', Kategorie.vyberBrzdnySystemTrenazer),
                  NastaveniKolaTest(true, Seznamy().vyrobceTrenazery, 'Výrobce',
                      Kategorie.vyberVyrobceTrenazer),
                  NastaveniKolaTest(true, Seznamy().pocitac, 'Počítač',
                      Kategorie.vyberPocitacTrenazer),
                  TextInputTest(true, Kategorie.vyberMaxNosnostTrenazer,
                      "Maximální nosnost (v kg)"),
                  TextInputTest(true, Kategorie.vyberDojezdElektrokola,
                      "Maximální dojezd"),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.005,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.045,
              width: MediaQuery.of(context).size.height,
              child: ElevatedButton(
                  child: Text('Další'),
                  onPressed: () {
                    Navigator.of(context).push(_stranaTvorbaInzeratu());
                  }),
            ),
          ],
        ));
  }
}

Route _stranaKolobezky() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => StranaKolobezky(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

class StranaKolobezky extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Kategorie.selectedKategorie),
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.84,
              child: ListView(
                children: <Widget>[
                  NastaveniKolaTest(true, Seznamy().velikostKolecek,
                      'Velikost koleček', Kategorie.vyberVelikostKolecek),
                  NastaveniKolaTest(true, Seznamy().vyrobceKolobezky, 'Výrobce',
                      Kategorie.vyberVyrobceKolobezky),
                  TextInputTest(true, Kategorie.vyberNosnostKolobezky,
                      "Maximální nosnost (v kg)"),
                  TextInputTest(
                      true, Kategorie.vyberDelkaKolobezky, "Délka (v cm)"),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.005,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.045,
              width: MediaQuery.of(context).size.height,
              child: ElevatedButton(
                  child: Text('Další'),
                  onPressed: () {
                    Navigator.of(context).push(_stranaTvorbaInzeratu());
                  }),
            ),
          ],
        ));
  }
}

Route _stranaOdrazedla() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => StranaOdrazedla(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

class StranaOdrazedla extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Kategorie.selectedKategorie),
      ),
      //body:
    );
  }
}

Route _stranaSinglespeed() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        StranaSinglespeed(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

class StranaSinglespeed extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Kategorie.selectedKategorie),
      ),
      //body:
    );
  }
}

Route _stranaNastaveniKola() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        StranaNastaveniKola(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

class StranaNastaveniKola extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Kategorie.selectedKategorie),
      ),
      body: NastaveniKola(),
    );
  }
}

Route _stranaDetailKola() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => StranaDetailKola(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

class StranaDetailKola extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Kategorie.selectedKategorie),
        ),
        body: Container(
            margin: EdgeInsets.all(24),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    decoration:
                        new InputDecoration(labelText: "Zadejte rok výroby"),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ], // Only numbers can be entered
                  ),
                ],
              ),
            )));
  }
}

Route _stranaKomponenty() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => StranaKomponenty(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

class StranaKomponenty extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Kategorie.selectedKategorie),
      ),
      body: ListView(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.84,
          child: Kategorie(Seznamy().seznamKomponenty),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.05,
          child: ElevatedButton(
              child: Text('Další'),
              onPressed: () {
                NastaveniKomponenty.zapletenaKola = false;
                NastaveniKomponenty.kliky = false;
                NastaveniKomponenty.prevodniky = false;
                NastaveniKomponenty.sedla = false;
                NastaveniKomponenty.vidlice = false;
                switch (Kategorie.selectedKategorie) {
                  case 'Kliky':
                    {
                      Kategorie.vyberKategorie = 'kliky';
                      NastaveniKomponenty.kliky = true;
                      Navigator.of(context).push(_stranaNastaveniKomponenty());
                    }
                    break;
                  case 'Převodníky':
                    {
                      Kategorie.vyberKomponenty = 'prevodniky';
                      NastaveniKomponenty.prevodniky = true;
                      Navigator.of(context).push(_stranaNastaveniKomponenty());
                    }
                    break;
                  case 'Sedla':
                    {
                      Kategorie.vyberKomponenty = 'sedla';
                      NastaveniKomponenty.sedla = true;
                      Navigator.of(context).push(_stranaNastaveniKomponenty());
                    }
                    break;
                  case 'Vidlice':
                    {
                      Kategorie.vyberKomponenty = 'vidlice';
                      NastaveniKomponenty.vidlice = true;
                      Navigator.of(context).push(_stranaNastaveniKomponenty());
                    }
                    break;
                  case 'Zapletená kola':
                    {
                      Kategorie.vyberKomponenty = 'zapletenaKola';
                      NastaveniKomponenty.zapletenaKola = true;
                      Navigator.of(context).push(_stranaNastaveniKomponenty());
                    }
                    break;
                }
              }),
        )
      ]),
    );
  }
}

Route _stranaDoplnky() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => StranaDoplnky(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

class StranaDoplnky extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Kategorie.selectedKategorie),
      ),
      body: ListView(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.84,
          child: Kategorie(Seznamy().seznamDoplnky),
        ),
        Container(
            height: MediaQuery.of(context).size.height * 0.05,
            child: ElevatedButton(
                child: Text('Další'),
                onPressed: () {
                  if (Kategorie.selectedKategorie == 'Doplňky') {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Chyba'),
                            content: Text('Vyberte doplňek'),
                            actions: [
                              TextButton(
                                child: Text('Ok'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        });
                  } else {
                    Navigator.of(context).push(_stranaTvorbaInzeratu());
                  }
                }))
      ]),
    );
  }
}

Route _stranaOstatni() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => StranaOstatni(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

class StranaOstatni extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Kategorie.selectedKategorie),
      ),
      body: ListView(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.84,
          child: Kategorie(Seznamy().ostatni),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.05,
          child: ElevatedButton(
              child: Text('Další'),
              onPressed: () {
                if (Kategorie.selectedKategorie == 'Ostatní') {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Chyba'),
                          content: Text('Vyberte typ produktu'),
                          actions: [
                            TextButton(
                              child: Text('Ok'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      });
                } else {
                  Navigator.of(context).push(_stranaTvorbaInzeratu());
                }
              }),
        )
      ]),
    );
  }
}

Route _stranaTvorbaInzeratu() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        StranaTvorbaInzeratu(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

class StranaTvorbaInzeratu extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tvorba inzerátu'),
      ),
      body: TvorbaInzeratu(),
    );
  }
}

Route _stranaNastaveniKomponenty() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        StranaNastaveniKomponenty(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

class StranaNastaveniKomponenty extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Kategorie.selectedKategorie),
      ),
      body: NastaveniKomponenty(),
    );
  }
}
