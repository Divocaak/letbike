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

class _FilterPage extends State<FilterPage> {
  AddItemFiltersArgs addItemArgs;

  int widgetCount = 2;

  FilterSwitch usedSwitch =
      new FilterSwitch(label: "Použité", left: "Ne", right: "Ano");
  FilterDropdown categoryDd =
      new FilterDropdown(hint: "Kategorie", options: Category.categories);

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
    categoryDd.fp = this;
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
              case2(categoryDd.value, {1: brandDd, 2: typeDd}, Container())
            ],
          )
        ]));
  }

  TValue case2<TOptionType, TValue>(
    TOptionType selectedOption,
    Map<TOptionType, TValue> branches, [
    TValue defaultValue,
  ]) {
    if (!branches.containsKey(selectedOption)) {
      return defaultValue;
    }

    return branches[selectedOption];
  }
}
