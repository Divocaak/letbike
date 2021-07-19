import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:letbike/account/accountSettings.dart';
import 'package:letbike/app/filterPage.dart';
import 'package:letbike/article/articlePage.dart';
import 'package:letbike/article/articlesScreen.dart';
import 'package:letbike/filters/filtersBase.dart';
import 'package:letbike/filters/filtersBike.dart';
import 'package:letbike/filters/filtersComponent.dart';
import 'package:letbike/filters/filtersAccessory.dart';
import 'package:letbike/filters/filtersOtherBase.dart';
import 'filters/components/components.dart';
import 'filters/accessories/accessories.dart';
import 'filters/other/other.dart';
import 'sign/screens.dart';
import 'app/homePage.dart';
import 'app/itemPage.dart';
import 'chat/chatScreen.dart';
import 'account/accountScreen.dart';
import 'account/accountSettings.dart';
import 'account/accountChangePass.dart';
import 'addItem/addItem.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LetBike',
      theme: ThemeData(
        textTheme:
            GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => LoginScreen(),
        "ForgotPassword": (context) => ForgotPassword(),
        "CreateNewAccount": (context) => CreateNewAccount(),
        HomePage.routeName: (context) => HomePage(),
        ItemPage.routeName: (context) => ItemPage(),
        ChatScreen.routeName: (content) => ChatScreen(),
        AccountScreen.routeName: (context) => AccountScreen(),
        AccountSettings.routeName: (context) => AccountSettings(),
        ChangePassword.routeName: (context) => ChangePassword(),
        AddItem.routeName: (context) => AddItem(),
        ArticlesScreen.routeName: (context) => ArticlesScreen(),
        ArticlePage.routeName: (context) => ArticlePage(),
        //filters
        FilterPage.routeName: (context) => FilterPage(),
        FiltersBase.routeName: (context) => FiltersBase(),
        // - bike
        FiltersBike.routeName: (context) => FiltersBike(),
        // - components
        FiltersComponent.routeName: (context) => FiltersComponent(),
        FiltersAxis.routeName: (context) => FiltersAxis(),
        FiltersBowden.routeName: (context) => FiltersBowden(),
        FiltersBrakes.routeName: (context) => FiltersBrakes(),
        FiltersBrakeMore.routeName: (context) => FiltersBrakeMore(),
        FiltersCassette.routeName: (context) => FiltersCassette(),
        FiltersConverter.routeName: (context) => FiltersConverter(),
        FiltersCranks.routeName: (context) => FiltersCranks(),
        FiltersEBikeComponents.routeName: (context) => FiltersEBikeComponents(),
        FiltersFork.routeName: (context) => FiltersFork(),
        FiltersForkMore.routeName: (context) => FiltersForkMore(),
        FiltersFrame.routeName: (context) => FiltersFrame(),
        FiltersGearChange.routeName: (context) => FiltersGearChange(),
        FiltersGrips.routeName: (context) => FiltersGrips(),
        FiltersHandlebars.routeName: (context) => FiltersHandlebars(),
        FiltersHeadset.routeName: (context) => FiltersHeadset(),
        FiltersPedals.routeName: (context) => FiltersPedals(),
        FiltersRim.routeName: (context) => FiltersRim(),
        FiltersSaddle.routeName: (context) => FiltersSaddle(),
        FiltersSaddlePipe.routeName: (context) => FiltersSaddlePipe(),
        FiltersShockAbs.routeName: (context) => FiltersShockAbs(),
        FiltersStem.routeName: (context) => FiltersStem(),
        FiltersTires.routeName: (context) => FiltersTires(),
        FiltersTube.routeName: (context) => FiltersTube(),
        FiltersWheel.routeName: (context) => FiltersWheel(),
        FiltersWheelMore.routeName: (context) => FiltersWheelMore(),
        // - accessories
        FiltersAccessory.routeName: (context) => FiltersAccessory(),
        FiltersBoots.routeName: (context) => FiltersBoots(),
        FiltersBottleHolder.routeName: (context) => FiltersBottleHolder(),
        FiltersClothes.routeName: (context) => FiltersClothes(),
        FiltersClothesMore.routeName: (context) => FiltersClothesMore(),
        FiltersComps.routeName: (context) => FiltersComps(),
        FiltersGlasses.routeName: (context) => FiltersGlasses(),
        FiltersHelmet.routeName: (context) => FiltersHelmet(),
        FiltersKidSaddle.routeName: (context) => FiltersKidSaddle(),
        FiltersLight.routeName: (context) => FiltersLight(),
        FiltersLock.routeName: (context) => FiltersLock(),
        FiltersMudguard.routeName: (context) => FiltersMudguard(),
        FiltersPumps.routeName: (context) => FiltersPumps(),
        FiltersRack.routeName: (context) => FiltersRack(),
        FiltersTools.routeName: (context) => FiltersTools(),
        FiltersCarRack.routeName: (context) => FiltersCarRack(),
        // - other
        FiltersOtherBase.routeName: (context) => FiltersOtherBase(),
        FiltersEBike.routeName: (context) => FiltersEBike(),
        FiltersScooter.routeName: (context) => FiltersScooter(),
        FiltersTrainer.routeName: (context) => FiltersTrainer(),
      },
    );
  }
}
