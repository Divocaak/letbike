import 'package:flutter/material.dart';
import 'kategorie.dart';
import 'seznamy.dart';
import 'tvorbaInzeratu.dart';

class NastaveniKomponenty extends StatefulWidget {
  static bool zapletenaKola = false;
  static bool kliky = false;
  static bool prevodniky = false;
  static bool sedla = false;
  static bool vidlice = false;

  @override
  _NastaveniKomponentyState createState() => _NastaveniKomponentyState();
}

class _NastaveniKomponentyState extends State<NastaveniKomponenty> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.84,
          child: ListView(
            children: <Widget>[
              //kolo
              NastaveniKomponentyTest(
                  NastaveniKomponenty.zapletenaKola,
                  Seznamy().velikostKolo,
                  'Velikost kol',
                  Kategorie.vyberVelikostKolo),
              NastaveniKomponentyTest(
                  NastaveniKomponenty.zapletenaKola,
                  Seznamy().materialRafku,
                  'Materiál ráfku',
                  Kategorie.vyberMaterialRafku),
              NastaveniKomponentyTest(NastaveniKomponenty.zapletenaKola,
                  Seznamy().dratyKolo, 'Dráty kol', Kategorie.vyberDratyKolo),
              NastaveniKomponentyTest(
                  NastaveniKomponenty.zapletenaKola,
                  Seznamy().provedeniNaboje,
                  'Provedení náboje',
                  Kategorie.vyberProvedeniNaboje),
              NastaveniKomponentyTest(NastaveniKomponenty.zapletenaKola,
                  Seznamy().osaKolo, 'Osa kol', Kategorie.vyberOsaKolo),
              Container(
                child: NastaveniKomponenty.zapletenaKola
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
                                      TextButton(
                                        child: Text('Zrušit'),
                                        onPressed: () {
                                          Kategorie.vyberKategorieBrzdKolo =
                                              'prazdny';
                                          Navigator.pop(context);
                                        },
                                      ),
                                      TextButton(
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
                                                        TextButton(
                                                          child: Text('Zrušit'),
                                                          onPressed: () {
                                                            Kategorie
                                                                    .vyberKategorieBrzdKolo =
                                                                'prazdny';
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                        TextButton(
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
              NastaveniKomponentyTest(
                  NastaveniKomponenty.zapletenaKola,
                  Seznamy().upevneniKazetyPastorku,
                  'Upevnění kazety Pastorku',
                  Kategorie.vyberUpevneniKazetyPastorku),
              NastaveniKomponentyTest(
                  NastaveniKomponenty.zapletenaKola,
                  Seznamy().kompatibilitaKolo,
                  'Kompatibilita kol',
                  Kategorie.vyberKompatibilitaKolo),
              //kliky
              NastaveniKomponentyTest(
                  NastaveniKomponenty.kliky,
                  Seznamy().znackaKliky,
                  'Značka kliky',
                  Kategorie.vyberZnackaKliky),
              NastaveniKomponentyTest(
                  NastaveniKomponenty.kliky,
                  Seznamy().kompatibilitaKliky,
                  'Kompatibility klik',
                  Kategorie.vyberKompatibilitaKliky),
              NastaveniKomponentyTest(
                  NastaveniKomponenty.kliky,
                  Seznamy().materialKliky,
                  'Materiál klik',
                  Kategorie.vyberMaterialKliky),
              NastaveniKomponentyTest(NastaveniKomponenty.kliky,
                  Seznamy().osaKliky, 'Osa kliky', Kategorie.vyberOsaKliky),
              //prevodniky
              NastaveniKomponentyTest(
                  NastaveniKomponenty.prevodniky,
                  Seznamy().znackaPrevodniky,
                  'Značka převodníku',
                  Kategorie.vyberZnackaPrevodniky),
              NastaveniKomponentyTest(
                  NastaveniKomponenty.prevodniky,
                  Seznamy().pocetRychlostiPrevodniky,
                  'Počet rychlostí převodníku',
                  Kategorie.vyberPocetRychlostiPrevodniky),
              //sedla
              NastaveniKomponentyTest(
                  NastaveniKomponenty.sedla,
                  Seznamy().znackaSedla,
                  'Značka sedla',
                  Kategorie.vyberZnackaSedla),
              NastaveniKomponentyTest(
                  NastaveniKomponenty.sedla,
                  Seznamy().pohlaviSedla,
                  'Sedlo pohlaví',
                  Kategorie.vyberPohlaviSedla),
              //vidlice
              NastaveniKomponentyTest(
                  NastaveniKomponenty.vidlice,
                  Seznamy().znackaVidlice,
                  'Značka vidlice',
                  Kategorie.vyberZnackaVidlice),

              TextInputTestKomponenty(
                  NastaveniKomponenty.zapletenaKola,
                  Kategorie.vyberSirkaNaboje,
                  'Šířka náboje zapleteného kola (v mm)'),
              TextInputTestKomponenty(NastaveniKomponenty.zapletenaKola,
                  Kategorie.vyberPocetDratu, 'Počet drátů zapleteného kola'),
              TextInputTestKomponenty(
                  NastaveniKomponenty.zapletenaKola,
                  Kategorie.vyberSirkaRafku,
                  'Šířka ráfku zapleteného kola (v mm)'),
              TextInputTestKomponenty(
                  NastaveniKomponenty.zapletenaKola,
                  Kategorie.vyberVahaZapleteneKolo,
                  'Váha zapleteného kola (v kg)'),
              TextInputTestKomponenty(NastaveniKomponenty.kliky,
                  Kategorie.vyberNajezdKliky, 'Nájezd kliky (v km)'),
              TextInputTestKomponenty(NastaveniKomponenty.kliky,
                  Kategorie.vyberDelkaKliky, 'Délka kliky (v mm)'),
              TextInputTestKomponenty(NastaveniKomponenty.kliky,
                  Kategorie.vyberVahaKliky, 'Váha kliky (v g)'),
              TextInputTestKomponenty(
                  NastaveniKomponenty.vidlice,
                  Kategorie.vyberDelkaSloupkuVidlice,
                  'Délka sloupku vidlice (v mm)'),
              TextInputTestKomponenty(NastaveniKomponenty.vidlice,
                  Kategorie.vyberVahaVidlice, 'Váha vidlice (v g)'),
              Container(
                child: NastaveniKomponenty.vidlice
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
                                      TextButton(
                                        child: Text('Zrušit'),
                                        onPressed: () {
                                          Kategorie.vyberTyp1Vidlice =
                                              'prazdny';
                                          Navigator.pop(context);
                                        },
                                      ),
                                      TextButton(
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
                                                        TextButton(
                                                          child: Text('Zrušit'),
                                                          onPressed: () {
                                                            Kategorie
                                                                    .vyberOdpruzenaVidlice =
                                                                'prazdny';
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                        TextButton(
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
              NastaveniKomponentyTest(
                  NastaveniKomponenty.vidlice,
                  Seznamy().typ2Vidlice,
                  'Upevnění vidlice',
                  Kategorie.vyberTyp2Vidlice),
              NastaveniKomponentyTest(
                  NastaveniKomponenty.vidlice,
                  Seznamy().materialVidlice,
                  'Materiál vidlice',
                  Kategorie.vyberMaterialVidlice),
              NastaveniKomponentyTest(
                  NastaveniKomponenty.vidlice,
                  Seznamy().velikostVidlice,
                  'Velikost vidlice',
                  Kategorie.vyberVelikostVidlice),
              NastaveniKomponentyTest(
                  NastaveniKomponenty.vidlice,
                  Seznamy().materialSloupkuVidlice,
                  'Materiál sloupku vidlice',
                  Kategorie.vyberMaterialSloupkuVidlice),
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
    );
  }
}

class TextInputTestKomponenty extends StatefulWidget {
  String nadpis;
  bool nastaveni;
  String vyberTemporary;
  String vyber;

  // constructor
  TextInputTestKomponenty(bool nastaveni, String vyber, String nadpis) {
    this.nadpis = nadpis;
    this.nastaveni = nastaveni;
    this.vyber = vyber;
  }

  @override
  _TextInputTestKomponenty createState() => _TextInputTestKomponenty();
}

class _TextInputTestKomponenty extends State<TextInputTestKomponenty> {
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
                            TextButton(
                                child: Text('Zrušit'),
                                onPressed: () {
                                  widget.vyber = 'prazdny';
                                  Navigator.pop(context);
                                }),
                            TextButton(
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

class NastaveniKomponentyTest extends StatefulWidget {
  bool nastaveni;
  List<String> seznam;
  String nadpis;
  String vyber;

  // constructor
  NastaveniKomponentyTest(
      bool nastaveni, List<String> seznam, String nadpis, String vyber) {
    this.nastaveni = nastaveni;
    this.seznam = seznam;
    this.nadpis = nadpis;
    this.vyber = vyber;
  }

  @override
  _NastaveniKomponentyTest createState() => _NastaveniKomponentyTest();
}

class _NastaveniKomponentyTest extends State<NastaveniKomponentyTest> {
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
                            TextButton(
                                child: Text('Zrušit'),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                            TextButton(
                                child: Text('Potvrdit'),
                                onPressed: () {
                                  widget.vyber = Kategorie.selectedKategorie;
                                  print(widget.vyber);
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
