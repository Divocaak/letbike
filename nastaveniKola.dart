import 'dart:math';
import 'tvorbaInzeratu.dart';
import 'package:flutter/material.dart';
import 'kategorie.dart';
import 'seznamy.dart';
import 'main.dart';

class NastaveniKola extends StatefulWidget {
  static String value;

  static bool celoodpruzene = false;
  static bool elektrokolo = false;

  static bool znackaKola = true;
  static bool znackaKolo = true;
  static bool velikostKolo = true;
  static bool materialRafku = true;
  static bool dratyKolo = true;
  static bool provedeniNaboje = true;
  static bool osaKolo = true;
  static bool kategoreBrzdKolo = true;
  static bool upevneniKazetyPastorku = true;
  static bool orechKolo = true;
  static bool kompatibilitaKolo = true;
  static bool znackaKliky = true;
  static bool kompatibilitaKliky = true;
  static bool materialKliky = true;
  static bool osaKliky = true;
  static bool znackaPrevodniky = true;
  static bool pocetRychlostiPrevodniky = true;
  static bool znackaSedla = true;
  static bool pohlaviSedla = true;
  static bool znackaVidlice = true;
  static bool typ1Vidlice = true;
  static bool typ2Vidlice = true;
  static bool materialVidlice = true;
  static bool velikostVidlice = true;
  static bool materialSloupkuVidlice = true;
  //kolo
  static bool delkaKolo = true;
  static bool rokVyrobyKolo = true;
  //Zapletená kola
  static bool sirkaNaboje = true;
  static bool pocetDratu = true;
  static bool sirkaRafku = true;
  static bool vahaZapleteneKolo = true;
  //Kliky
  static bool najezdKliky = true;
  static bool delkaKliky = true;
  static bool vahaKliky = true;
  //Vidlice
  static bool zdvihVidlice = false; //pokud je vidlice odpružená tak true
  static bool delkaSloupkuVidlice = true;
  static bool vahaVidlice = true;
  //elektrokola
  static bool baterieElektrokola = false;
  static bool dojezdElektrokola = false;
  static bool umisteniMotoruElektrokolo = false;
  static bool vyrobceElektrokola = false;
  //Trenažéry
  static bool maxNosnostTrenazer = false;
  static bool pocitacTrenazer = false;
  static bool brzdnySystemTrenazer = false;
  static bool vyrobceTrenazer = false;
  //Koloběžky
  static bool velikostKolecek = false;
  static bool vahaKolobezka = false;
  static bool nosnostKolobezky = false;
  static bool vyrobceKolobezky = false;

  @override
  _NastaveniKolaState createState() => _NastaveniKolaState();
}

class _NastaveniKolaState extends State<NastaveniKola> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.84,
          child: ListView(
            children: <Widget>[
              //elektrokolo
              NastaveniKolaTest(
                  NastaveniKola.elektrokolo,
                  Seznamy().umisteniMotoru,
                  'Umístění motoru',
                  Kategorie.vyberUmisteniMotoruElektrokolo),
              NastaveniKolaTest(
                  NastaveniKola.elektrokolo,
                  Seznamy().vyrobceElektrokola,
                  'Výrobce',
                  Kategorie.vyberVyrobceElektrokola),
              TextInputTest(NastaveniKola.elektrokolo,
                  Kategorie.vyberBaterieElektrokola, "Velikost baterie (v Ah)"),
              TextInputTest(NastaveniKola.elektrokolo,
                  Kategorie.vyberDojezdElektrokola, "Maximální dojezd"),
              //zbytek
              NastaveniKolaTest(NastaveniKola.znackaKola, Seznamy().znackaKola,
                  'Značka kola', Kategorie.vyberZnackaKola),
              NastaveniKolaTest(NastaveniKola.znackaKolo, Seznamy().znackaKolo,
                  'Značka pneu', Kategorie.vyberZnackaKolo),
              NastaveniKolaTest(
                  NastaveniKola.velikostKolo,
                  Seznamy().velikostKolo,
                  'Velikost kol',
                  Kategorie.vyberVelikostKolo),
              NastaveniKolaTest(
                  NastaveniKola.materialRafku,
                  Seznamy().materialRafku,
                  'Materiál ráfku',
                  Kategorie.vyberMaterialRafku),
              NastaveniKolaTest(NastaveniKola.dratyKolo, Seznamy().dratyKolo,
                  'Dráty kol', Kategorie.vyberDratyKolo),
              NastaveniKolaTest(
                  NastaveniKola.provedeniNaboje,
                  Seznamy().provedeniNaboje,
                  'Provedení náboje',
                  Kategorie.vyberProvedeniNaboje),
              NastaveniKolaTest(NastaveniKola.osaKolo, Seznamy().osaKolo,
                  'Osa kol', Kategorie.vyberOsaKolo),
              TextInputTest(NastaveniKola.celoodpruzene,
                  Kategorie.vyberZdvihVidlice, 'Zdvih vidlice (v mm)'),
              Container(
                child: true
                    ? Padding(
                        padding: EdgeInsets.only(
                            top: 8, bottom: 4, right: 16, left: 16),
                        child: InkWell(
                          child: Container(
                            height: 40,
                            child: Center(
                              child: Text('Brzdy',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            color: Colors.blue,
                          ),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Brzdy'),
                                    content: Container(
                                        height: 340,
                                        width: 200,
                                        child: Kategorie(
                                            Seznamy().kategorieBrzdKolo)),
                                    actions: [
                                      FlatButton(
                                        child: Text('Zrušit'),
                                        onPressed: () {
                                          Kategorie.vyberKategorieBrzdKolo =
                                              'prazdny';
                                          Navigator.pop(context);
                                        },
                                      ),
                                      FlatButton(
                                          child: Text('Potvrdit'),
                                          onPressed: () {
                                            Kategorie.vyberKategorieBrzdKolo =
                                                Kategorie.selectedKategorie;
                                            print(Kategorie
                                                .vyberKategorieBrzdKolo);
                                            Navigator.pop(context);
                                            if (Kategorie.selectedKategorie ==
                                                'Kotoučové brzdy') {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          'Typ kotoučových brzd'),
                                                      content: Container(
                                                          height: 340,
                                                          width: 200,
                                                          child: Kategorie(Seznamy()
                                                              .kotoucoveBrzdyKolo)),
                                                      actions: [
                                                        FlatButton(
                                                          child: Text('Zrušit'),
                                                          onPressed: () {
                                                            Kategorie
                                                                    .vyberKategorieBrzdKolo =
                                                                'prazdny';
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                        FlatButton(
                                                            child: Text(
                                                                'Potvrdit'),
                                                            onPressed: () {
                                                              Kategorie
                                                                      .vyberKategorieBrzdKolo =
                                                                  Kategorie
                                                                      .selectedKategorie;
                                                              print(Kategorie
                                                                  .vyberKategorieBrzdKolo);
                                                              Navigator.pop(
                                                                  context);
                                                            })
                                                      ],
                                                    );
                                                  });
                                            }
                                          })
                                    ],
                                  );
                                });
                          },
                        ))
                    : Container(height: 0),
              ),
              NastaveniKolaTest(
                  NastaveniKola.upevneniKazetyPastorku,
                  Seznamy().upevneniKazetyPastorku,
                  'Upevnění kazety Pastorku',
                  Kategorie.vyberUpevneniKazetyPastorku),
              NastaveniKolaTest(
                  NastaveniKola.kompatibilitaKolo,
                  Seznamy().kompatibilitaKolo,
                  'Kompatibilita kol',
                  Kategorie.vyberKompatibilitaKolo),
              NastaveniKolaTest(
                  NastaveniKola.kompatibilitaKliky,
                  Seznamy().kompatibilitaKliky,
                  'Kompatibility klik',
                  Kategorie.vyberKompatibilitaKliky),
              NastaveniKolaTest(
                  NastaveniKola.znackaKliky,
                  Seznamy().znackaKliky,
                  'Značka kliky',
                  Kategorie.vyberZnackaKliky),
              NastaveniKolaTest(
                  NastaveniKola.materialKliky,
                  Seznamy().materialKliky,
                  'Materiál klik',
                  Kategorie.vyberMaterialKliky),
              NastaveniKolaTest(NastaveniKola.osaKliky, Seznamy().osaKliky,
                  'Osa kliky', Kategorie.vyberOsaKliky),
              NastaveniKolaTest(
                  NastaveniKola.znackaPrevodniky,
                  Seznamy().znackaPrevodniky,
                  'Značka převodníku',
                  Kategorie.vyberZnackaPrevodniky),
              NastaveniKolaTest(
                  NastaveniKola.pocetRychlostiPrevodniky,
                  Seznamy().pocetRychlostiPrevodniky,
                  'Počet rychlostí převodníku',
                  Kategorie.vyberPocetRychlostiPrevodniky),
              NastaveniKolaTest(
                  NastaveniKola.znackaSedla,
                  Seznamy().znackaSedla,
                  'Značka sedla',
                  Kategorie.vyberZnackaSedla),
              NastaveniKolaTest(
                  NastaveniKola.pohlaviSedla,
                  Seznamy().pohlaviSedla,
                  'Sedlo pohlaví',
                  Kategorie.vyberPohlaviSedla),
              NastaveniKolaTest(
                  NastaveniKola.znackaVidlice,
                  Seznamy().znackaVidlice,
                  'Značka vidlice',
                  Kategorie.vyberZnackaVidlice),
              Container(
                child: NastaveniKola.typ1Vidlice
                    ? Padding(
                        padding: EdgeInsets.only(
                            top: 8, bottom: 4, right: 16, left: 16),
                        child: InkWell(
                          child: Container(
                            height: 40,
                            child: Center(
                              child: Text('Odpružení vidlice',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            color: Colors.blue,
                          ),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Odpružení vidlice'),
                                    content: Container(
                                        height: 340,
                                        width: 200,
                                        child:
                                            Kategorie(Seznamy().typ1Vidlice)),
                                    actions: [
                                      FlatButton(
                                        child: Text('Zrušit'),
                                        onPressed: () {
                                          Kategorie.vyberTyp1Vidlice =
                                              'prazdny';
                                          Navigator.pop(context);
                                        },
                                      ),
                                      FlatButton(
                                          child: Text('Potvrdit'),
                                          onPressed: () {
                                            Kategorie.vyberTyp1Vidlice =
                                                Kategorie.selectedKategorie;
                                            print(Kategorie.vyberTyp1Vidlice);
                                            Navigator.pop(context);
                                            if (Kategorie.selectedKategorie ==
                                                'Odpružená') {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          'Typ odpružení vidlice'),
                                                      content: Container(
                                                          height: 340,
                                                          width: 200,
                                                          child: Kategorie(Seznamy()
                                                              .odpruzenaVidlice)),
                                                      actions: [
                                                        FlatButton(
                                                          child: Text('Zrušit'),
                                                          onPressed: () {
                                                            Kategorie
                                                                    .vyberOdpruzenaVidlice =
                                                                'prazdny';
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                        FlatButton(
                                                            child: Text(
                                                                'Potvrdit'),
                                                            onPressed: () {
                                                              Kategorie
                                                                      .vyberOdpruzenaVidlice =
                                                                  Kategorie
                                                                      .selectedKategorie;
                                                              print(Kategorie
                                                                  .vyberOdpruzenaVidlice);
                                                              Navigator.pop(
                                                                  context);
                                                            })
                                                      ],
                                                    );
                                                  });
                                            }
                                          })
                                    ],
                                  );
                                });
                          },
                        ))
                    : Container(height: 0),
              ),
              NastaveniKolaTest(
                  NastaveniKola.typ2Vidlice,
                  Seznamy().typ2Vidlice,
                  'Upevnění vidlice',
                  Kategorie.vyberTyp2Vidlice),
              NastaveniKolaTest(
                  NastaveniKola.materialVidlice,
                  Seznamy().materialVidlice,
                  'Materiál vidlice',
                  Kategorie.vyberMaterialVidlice),
              NastaveniKolaTest(
                  NastaveniKola.velikostVidlice,
                  Seznamy().velikostVidlice,
                  'Velikost vidlice',
                  Kategorie.vyberVelikostVidlice),
              NastaveniKolaTest(
                  NastaveniKola.materialSloupkuVidlice,
                  Seznamy().materialSloupkuVidlice,
                  'Materiál sloupku vidlice',
                  Kategorie.vyberMaterialSloupkuVidlice),
              TextInputTest(NastaveniKola.delkaKolo, Kategorie.vyberDelkaKolo,
                  'Délka kola (v cm)'),
              TextInputTest(NastaveniKola.rokVyrobyKolo,
                  Kategorie.vyberRokVyroby, 'Vyber rok výroby'),
              TextInputTest(
                  NastaveniKola.sirkaNaboje,
                  Kategorie.vyberSirkaNaboje,
                  'Šířka náboje zapleteného kola (v mm)'),
              TextInputTest(NastaveniKola.pocetDratu, Kategorie.vyberPocetDratu,
                  'Počet drátů zapleteného kola'),
              TextInputTest(NastaveniKola.sirkaRafku, Kategorie.vyberSirkaRafku,
                  'Šířka ráfku zapleteného kola (v mm)'),
              TextInputTest(
                  NastaveniKola.vahaZapleteneKolo,
                  Kategorie.vyberVahaZapleteneKolo,
                  'Váha zapleteného kola (v kg)'),
              TextInputTest(NastaveniKola.najezdKliky,
                  Kategorie.vyberNajezdKliky, 'Nájezd kliky (v km)'),
              TextInputTest(NastaveniKola.delkaKliky, Kategorie.vyberDelkaKliky,
                  'Délka kliky (v mm)'),
              TextInputTest(NastaveniKola.vahaKliky, Kategorie.vyberVahaKliky,
                  'Váha kliky (v g)'),
              TextInputTest(
                  NastaveniKola.delkaSloupkuVidlice,
                  Kategorie.vyberDelkaSloupkuVidlice,
                  'Délka sloupku vidlice (v mm)'),
              TextInputTest(NastaveniKola.vahaVidlice,
                  Kategorie.vyberVahaVidlice, 'Váha vidlice (v g)'),
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
                Navigator.of(context).push(_StranaTvorbaInzeratu());
              }),
        ),
      ],
    ));
  }
}

class TextInputTest extends StatefulWidget {
  String nadpis;
  bool nastaveni;
  String vyberTemporary;
  String vyber;

  // constructor
  TextInputTest(bool nastaveni, String vyber, String nadpis) {
    this.nadpis = nadpis;
    this.nastaveni = nastaveni;
    this.vyber = vyber;
  }

  @override
  _TextInputTest createState() => _TextInputTest();
}

class _TextInputTest extends State<TextInputTest> {
  final TextEditingController _controller = TextEditingController();

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.nastaveni
          ? Padding(
              padding: EdgeInsets.only(top: 8, bottom: 4, right: 16, left: 16),
              child: InkWell(
                child: Container(
                  height: 40,
                  child: Center(
                    child: Text(widget.nadpis,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  color: Colors.blue,
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(widget.nadpis),
                          content: Container(
                            child: TextFormField(
                              controller: _controller,
                              onChanged: (String value) async {
                                widget.vyberTemporary = value;
                              },
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          actions: [
                            FlatButton(
                                child: Text('Zrušit'),
                                onPressed: () {
                                  widget.vyber = 'prazdny';
                                  Navigator.pop(context);
                                }),
                            FlatButton(
                                child: Text('Potvrdit'),
                                onPressed: () {
                                  widget.vyber = widget.vyberTemporary;
                                  print(widget.vyber);
                                  Navigator.pop(context);
                                })
                          ],
                        );
                      });
                },
              ))
          : Container(height: 0),
    );
  }
}

class NastaveniKolaTest extends StatefulWidget {
  bool nastaveni;
  List<String> seznam;
  String nadpis;
  String vyber;

  // constructor
  NastaveniKolaTest(
      bool nastaveni, List<String> seznam, String nadpis, String vyber) {
    this.nastaveni = nastaveni;
    this.seznam = seznam;
    this.nadpis = nadpis;
    this.vyber = vyber;
  }

  @override
  _NastaveniKolaTest createState() => _NastaveniKolaTest();
}

class _NastaveniKolaTest extends State<NastaveniKolaTest> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.nastaveni
          ? Padding(
              padding: EdgeInsets.only(top: 8, bottom: 4, right: 16, left: 16),
              child: InkWell(
                child: Container(
                  height: 40,
                  child: Center(
                    child: Text(widget.nadpis,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  color: Colors.blue,
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(widget.nadpis),
                          content: Container(
                              height: 340,
                              width: 200,
                              child: Kategorie(widget.seznam)),
                          actions: [
                            FlatButton(
                              child: Text('Zrušit'),
                              onPressed: () {
                                widget.vyber = 'prazdny';
                                Navigator.pop(context);
                              },
                            ),
                            FlatButton(
                                child: Text('Potvrdit'),
                                onPressed: () {
                                  widget.vyber = Kategorie.selectedKategorie;
                                  print(widget.vyber);
                                  Navigator.pop(context);
                                })
                          ],
                        );
                      });
                },
              ))
          : Container(height: 0),
    );
  }
}

Route _StranaTvorbaInzeratu() {
  //TODO kola
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
