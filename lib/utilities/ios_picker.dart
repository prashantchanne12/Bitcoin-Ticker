import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bitcoin_ticker/coin_data.dart';

CupertinoPicker IOSPicker() {
  List<Widget> pickerItems = [];

  for (String item in currenciesList) {
    pickerItems.add(Text(item));
  }

  return CupertinoPicker(
    backgroundColor: Colors.lightBlue,
    itemExtent: 32.0,
    onSelectedItemChanged: (selectedIndex) {
      print(selectedIndex);
    },
    children: pickerItems,
  );
}