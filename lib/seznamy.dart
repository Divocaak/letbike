class Seznamy {
//Kategorie produktů
  List<String> kategorie = ['Kola', 'Komponenty', 'Doplňky', 'Ostatní'];

  List<String> seznamKomponenty = [
    "Kliky",
    "Převodníky",
    "Sedla",
    "Vidlice",
    "Zapletená kola",
  ];

  List<String> seznamDoplnky = [
    "Blatníky",
    "Brašny/batohy",
    "Brýle",
    "Cyklocomputery",
    "Dětské sedačky",
    "Helmy",
    "Hustilky",
    "Košíky na lahev",
    "Nářadí",
    "Nosič na kolo",
    "Nosiče",
    "Oblečení",
    "Obuv",
    "Poukazy",
    "Světla",
    "Výživa",
    "Zámky",
  ];

//Kolo
  List<String> druhKola = [
    "Horská kola",
    "Silniční kola",
    "Celoodpružené", // bez odpružení
    "Enduro",
    "Elektrokola", // +elektro info
    "Dětská kola",
    "Krosová/Trekingová kola",
    "Gravel/Cyklokros",
    "Historická kola",
    "Retro kola",
    "Dámská kola",
    "Městská kola",
    "Sjezdová kola",
    "Bmx kola", //konec
    "Dirtová kola",
    "Trenažéry", // custom(zátěž)
    "Koloběžky", // custom
    "Odrážedla", // custom(jako koloběžky)
    "Dráhová kola",
    "Singlespeed", // custom(if my dobrý -> jako koloběžky)
    "Fatbike",
    "Skládací kola",
    "Cargobike",
    "Jiné"
  ];

  List<String> znackaKola = [
    "4Ever",
    "Acra",
    "Amulet",
    "Apache",
    "Author",
    "Bianchi",
    "Cannonadale",
    "CTM",
    "Cube",
    "Denver",
    "Dino",
    "Fox",
    "Galaxy",
    "Ghost",
    "Giant",
    "GT",
    "Kellys",
    "Koss",
    "KTM",
    "Lapierre",
    "Leader",
    "Liberty",
    "Maxbike",
    "Merida",
    "MMR",
    "MRX",
    "Norco",
    "Olpran",
    "Orbea",
    "Rock Machine",
    "Scott",
    "Scud",
    "Specialized",
    "Stevens",
    "Superior",
    "Trek",
    "Jiné"
  ];
//Zapletené kola
  List<String> znackaKolo = [
    "Author",
    "Bontrager",
    "Campagnolo",
    "Dema",
    "DT Swiss",
    "Easton",
    "FFWD",
    "Force",
    "FSA",
    "Fulcrum",
    "Giant",
    "Kellys",
    "Lightweight",
    "Mach",
    "Mavic",
    "Miche",
    "Novatech",
    "Remerx",
    "Rodi",
    "Shimano",
    "Specialized",
    "Sram",
    "Veltec",
    "Vision Tech",
    "XLC",
    "Zipp",
  ];

  List<String> velikostKolo = [
    "12’",
    "14’",
    "16’",
    "20’",
    "23’",
    "24’",
    "25’",
    "26’",
    "27,5’",
    "28’",
    "29’"
  ];

  List<String> materialRafku = ["Karbon", "Hlíník", "ocel"];

  List<String> dratyKolo = ["Ploché", "Kulaté"];

  List<String> provedeniNaboje = ["Přední", "Zadní"];

  List<String> osaKolo = [
    "Pevná 20 mm",
    "Pevná 15 mm",
    "Pevná 12mm",
    "Rychloupínák",
    "Na matice"
  ];

  List<String> kategorieBrzdKolo = ["Kotoučové brzdy", "V-brzdy"];

  List<String> kotoucoveBrzdyKolo = ["CenterLock", "6 děr"]; //

  List<String> upevneniKazetyPastorku = ["Závit - šroubovací kolečko", "Ořech"];

  List<String> orechKolo = ["Shimano", "Sram", "Campagnolo"];

  List<String> kompatibilitaKolo = [
    "12 rychlostí",
    "11 rychlostí",
    "10 rychlostí",
    "9 rychlostí",
    "8 rychlostí",
    "7 rychlostí",
    "6 rychlostí",
    "1 rychlost"
  ];
//Kliky
  List<String> znackaKliky = [
    "Aerozine",
    "Campagnolo",
    "Force",
    "FSA",
    "Prowhell",
    "Race Face",
    "Rotor",
    "Shimano",
    "SR Suntour",
    "Sram",
    "Sturney Archer",
    "Sunrace",
    "Truvativ",
    "Jiné"
  ];
  List<String> kompatibilitaKliky = [
    "1 Převodník",
    "2 Převodníky",
    "3 Převodníky"
  ];

  List<String> materialKliky = ["Karbon", "Ocel", "Hliník"];

  List<String> osaKliky = ["DUB", "29 mm", "24 mm", "BB30", "4hran", "Isis"];
//Prevodniky
  List<String> znackaPrevodniky = [
    "absoluteBLACK",
    "Aerozine",
    "BBB",
    "Campagnolo",
    "Da Bomb",
    "E*13",
    "Fireeye",
    "Force",
    "FSA",
    "Gebhardt",
    "Manobike",
    "MAX1",
    "Prowheel",
    "Renthal",
    "Ridea",
    "Rotor",
    "Shaman Racing",
    "Shimano",
    "SR Suntour",
    "Sram",
    "Stronglight",
    "Total BMX",
    "Truvativ",
    "Jiné"
  ];

  List<String> pocetRychlostiPrevodniky = [
    "1",
    "2",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12"
  ];
//Sedla
  List<String> znackaSedla = [
    "Author",
    "BBB",
    "Bontrager",
    "Brooks",
    "DDK",
    "Ergon",
    "Fabric",
    "Felt",
    "Fizik",
    "Force",
    "Giant",
    "Kellys",
    "Pro",
    "Prologo",
    "San Marco",
    "Selle Bassano",
    "Selle Italia",
    "Selle Monte Grappa",
    "Selle Royal",
    "Selle San Marco",
    "Selle SMP",
    "Specialized",
    "Sportourer",
    "Velo",
    "Wittkop",
    "WTB",
    "XLC",
    "Jiné"
  ];

  List<String> pohlaviSedla = ["Unisex", "Pánské", "Dámské", "Dětské"];
//Vidlice
  List<String> znackaVidlice = [
    "Cane Creek",
    "Cannondale",
    "Cyklo Žitný",
    "DVO suspension",
    "Éclat",
    "Felt",
    "Force",
    "Fox",
    "GT",
    "Macneil",
    "Magura",
    "Manitou",
    "Marzocchi",
    "Maxbike",
    "MRX",
    "M-Wave",
    "Noxon",
    "NS Bikes",
    "Odyssey",
    "Öhlins",
    "Pells",
    "Rock Shox",
    "RST",
    "Spinner",
    "SR Suntour",
    "Total BMX",
    "TWN",
    "WTP",
    "Zoom",
    "Jiné"
  ];

  List<String> typ1Vidlice = ["Odpružená", "Pevná"];

  List<String> odpruzenaVidlice = ["Vzduchová", "Pružinová"]; //

  List<String> materialVidlice = ["Ocel", "Karbon", "Hliník", "Titan"];

  List<String> velikostVidlice = [
    "12’",
    "14’",
    "16’",
    "20’",
    "23’",
    "24’",
    "25’",
    "26’",
    "27,5’",
    "28’",
    "29’"
  ];

  List<String> typ2Vidlice = ["Rychloupínák", "Pevná osa", "Matice"];

  List<String> materialSloupkuVidlice = ["Karbon", "Ocel", "Hliník"];
//Ostatní
  List<String> ostatni = [
    "Bowdeny a lanka",
    "Brzdy",
    "Duše",
    "Gripy a omotávky",
    "Hlavová složení",
    "Kazety a pastorky",
    "Náboje a osy",
    "Pedály",
    "Pláště/Galusky",
    "Představce",
    "Příslušenství na elektrokola",
    "Ráfky",
    "Rámy",
    "Řazení",
    "Řídítka",
    "Sedlovky",
    "Tlumiče",
    "Jiné"
  ];

//Speciální

//Elektrokola
  List<String> umisteniMotoru = ["Středový", "Nábojový"];
  List<String> vyrobceElektrokola = [
    "Crussis",
    "Haibike",
    "Apache",
    "Rock Machine",
    "Leader Fox",
    "Jiné"
  ];

//Trenažéry
  List<String> brzdnySystemTrenazery = ["magnetický", "indukční", "páskový"];
  List<String> vyrobceTrenazery = [
    "HMS",
    "Tunturi",
    "BH Fitness",
    "InSPORTline",
    "Spokey",
    "Jiné"
  ];

//Koloběžky
  List<String> velikostKolecek = [
    "přední 26’ a zadní 20’",
    "přední 16’ a zadní 12’",
    "přední 12’ a zadní 12’",
    "přední 16’ a zadní 16’",
    "přední 20’ a zadní 20’",
    "přední 20’ a zadní 16’",
    "přední 28’ a zadní 20’",
    "přední 20’ a zadní 12’",
    "přední 28’ a zadní 18’",
    "přední 14’ a zadní 12’",
    "přední 26’ a zadní 16’",
    "přední 28’ a zadní 28’",
    "přední 22’ a zadní 12’",
    "přední 230 mm, zadní 180 mm",
  ];
  List<String> vyrobceKolobezky = [
    "AO",
    "Bestial Wolf",
    "Blazer",
    "Blunt",
    "Crisp",
    "Crussis",
    "District",
    "Dominator",
    "Enero",
    "Ethic",
    "Frenzy",
    "Galaxy",
    "Globber",
    "Grit",
    "Hudora",
    "Chilli",
    "InSPORTline",
    "JD Bug",
    "Kickbike",
    "Kostka",
    "Longway",
    "Lucky",
    "Madd Gear",
    "Master",
    "Meteor",
    "Mibo",
    "Micro",
    "Milly Mally",
    "Mondo",
    "Morxes",
    "Movino",
    "Nils",
    "North Scooters",
    "Oxelo",
    "Panda",
    "Raven",
    "Razor",
    "Root Industries",
    "R-Sport",
    "Scoot & Ride",
    "Sedco",
    "Schildkrot",
    "Slamm",
    "Smoby",
    "Spartan",
    "Spokey",
    "Stiga",
    "Street Surfing",
    "Striker",
    "Tempish",
    "Worker",
    "Yedoo",
    "Jiné"
  ];
  List<String> pocitac = ["Ano", "Ne"];
}
