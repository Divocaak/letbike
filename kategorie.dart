import 'package:flutter/material.dart';

class Kategorie extends StatefulWidget {
  final List<String> kategorie;

  Kategorie(this.kategorie);
  static String selectedKategorie = 'prazdny';
  static String vyberKategorie = 'prazdny';
  static String vyberDruhKola = 'prazdny';
  static String vyberZnackaKola = 'prazdny';
  static String vyberZnackaKolo = 'prazdny';
  static String vyberKomponenty = 'prazdny';
  static bool pouzite = true;
  static String vyberDelkaKolo;
  static String vyberRokVyroby;

  //zapletená kola
  static String vyberVelikostKolo = 'prazdny';
  static String vyberMaterialRafku = 'prazdny';
  static String vyberDratyKolo = 'prazdny';
  static String vyberProvedeniNaboje = 'prazdny';
  static String vyberOsaKolo = 'prazdny';
  static String vyberKategorieBrzdKolo = 'prazdny';

  static String vyberKotoucoveBrzdyKolo = 'prazdny';

  static String vyberUpevneniKazetyPastorku = 'prazdny';
  static String vyberOrechKolo = 'prazdny';
  static String vyberKompatibilitaKolo = 'prazdny';
  static String vyberSirkaNaboje;
  static String vyberPocetDratu;
  static String vyberSirkaRafku;
  static String vyberVahaZapleteneKolo;
  //kliky
  static String vyberZnackaKliky = 'prazdny';
  static String vyberKompatibilitaKliky = 'prazdny';
  static String vyberMaterialKliky = 'prazdny';
  static String vyberOsaKliky = 'prazdny';
  static String vyberNajezdKliky;
  static String vyberDelkaKliky;
  static String vyberVahaKliky;
  //prevodniky
  static String vyberZnackaPrevodniky = 'prazdny';
  static String vyberPocetRychlostiPrevodniky = 'prazdny';
  //sedla
  static String vyberZnackaSedla = 'prazdny';
  static String vyberPohlaviSedla = 'prazdny';
  //vidlice
  static String vyberZnackaVidlice = 'prazdny';
  static String vyberTyp1Vidlice = 'prazdny';
  static String vyberTyp2Vidlice = 'prazdny';
  static String vyberMaterialVidlice = 'prazdny';
  static String vyberVelikostVidlice = 'prazdny';
  static String vyberMaterialSloupkuVidlice = 'prazdny';
  static String vyberZdvihVidlice; //pokud je vidlice odpružená tak true
  static String vyberDelkaSloupkuVidlice;
  static String vyberVahaVidlice;
  static String vyberOdpruzenaVidlice = 'prazdny';
  //elektrokola
  static String vyberBaterieElektrokola; //uziv
  static String vyberDojezdElektrokola; //uziv
  static String vyberUmisteniMotoruElektrokolo = 'prazdny';
  static String vyberVyrobceElektrokola = 'prazdny';
  //Trenažéry
  static String vyberMaxNosnostTrenazer; //uziv
  static String vyberPocitacTrenazer = 'prazdny';
  static String vyberBrzdnySystemTrenazer = 'prazdny';
  static String vyberVyrobceTrenazer = 'prazdny';
  //Koloběžky
  static String vyberVelikostKolecek = 'prazdny';
  static String vyberVahaKolobezka; //uziv
  static String vyberNosnostKolobezky; //uziv
  static String vyberVyrobceKolobezky = 'prazdny';
  static String vyberDelkaKolobezky = 'prazdny';

  @override
  _Kategorie createState() => _Kategorie();
}

class _Kategorie extends State<Kategorie> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Kategorie.selectedKategorie = widget.kategorie[index];
            setState(() {});
          },
          child: Container(
            color: Kategorie.selectedKategorie == widget.kategorie[index]
                ? Colors.green[100].withOpacity(0.5)
                : null,
            child: Row(
              children: <Widget>[
                Radio(
                    value: widget.kategorie[index],
                    groupValue: Kategorie.selectedKategorie,
                    onChanged: (s) {
                      Kategorie.selectedKategorie = s;
                      setState(() {});
                    }),
                Text(widget.kategorie[index]),
              ],
            ),
          ),
        );
      },
      itemCount: widget.kategorie.length,
    );
  }
}
