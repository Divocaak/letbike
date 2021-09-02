import 'package:flutter/material.dart';
import 'package:letbike/addItem/addItem.dart';
import 'package:letbike/app/homePage.dart';
import 'package:letbike/filters/filtersBase.dart';
import '../general/general.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPage createState() => _FilterPage();

  static const routeName = "/filterPage";
}

class _FilterPage extends State<FilterPage> with TickerProviderStateMixin {
  AddItemFiltersArgs addItemArgs;

  int widgetCount = 2;

  FilterDropdown categoryDd = new FilterDropdown(
    hint: "Kategorie",
    options: Category.categories,
    //onTap: () => setState(() {}),
  );
  FilterSwitch usedSwitch =
      new FilterSwitch(label: "Použité", left: "Ne", right: "Ano");

  FilterDropdown brandDd =
      new FilterDropdown(hint: "Značka kola", options: Bike.brand);
  FilterDropdown typeDd =
      new FilterDropdown(hint: "Typ kola", options: Bike.type);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    addItemArgs = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        floatingActionButton: MainButton(
            iconData: Icons.save,
            onPressed: () => addItemArgs.addItemData == null
                ? Navigator.of(context).pushReplacementNamed(HomePage.routeName,
                    arguments: addItemArgs.args)
                : Navigator.of(context).pushReplacementNamed(AddItem.routeName,
                    arguments: addItemArgs)),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Stack(children: [
          BackgroundImage(),
          ListView(
            children: [
              usedSwitch,
              categoryDd,
            ],
          )
        ]));
  }

  rebuilder() {
    setState(() {});
  }
}
