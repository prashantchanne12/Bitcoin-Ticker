import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'networking.dart';
import 'utilities/ios_picker.dart';
import 'constants.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String data;
  Data d;
  var decodedData;
  var BTCprice;
  var ETHprice;
  var LTCprice;
  String selectedCurrency = 'USD';
  var currencyCoin;

  @override
  void initState() {
    super.initState();

    updateBTCPrice('USD');
    updateETHPrice('USD');
    updateLTCPrice('USD');
  }

  final bitcoinURL = 'https://apiv2.bitcoinaverage.com/indices/global/ticker/';

  void updateAllCurrency(
      {@required var currency, @required var currencyType}) {}

  void updateBTCPrice(var currency) async {
    d = new Data(
        url:
            'https://apiv2.bitcoinaverage.com/indices/global/ticker/${cryptoList[0]}$currency');
    decodedData = await d.getPrice();

    setState(() {
      BTCprice = decodedData['last'];
      currencyCoin = currency;
    });
  }

  void updateETHPrice(var currency) async {
    d = new Data(
        url:
            'https://apiv2.bitcoinaverage.com/indices/global/ticker/${cryptoList[1]}$currency');
    decodedData = await d.getPrice();

    setState(() {
      ETHprice = decodedData['last'];
      currencyCoin = currency;
    });
  }

  void updateLTCPrice(var currency) async {
    d = new Data(
        url:
            'https://apiv2.bitcoinaverage.com/indices/global/ticker/${cryptoList[2]}$currency');
    decodedData = await d.getPrice();

    setState(() {
      LTCprice = decodedData['last'];
      currencyCoin = currency;
    });
  }

  DropdownButton getDropdownButton() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(
          currency,
          style: TextStyle(
            fontSize: 22.0,
          ),
        ),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      iconSize: 30.0,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          updateBTCPrice(value);
          updateETHPrice(value);
          updateLTCPrice(value);
        });
      },
      items: dropdownItems,
    );
  }

  Widget getPicker() {
    if (Platform.isIOS) {
      return IOSPicker();
    } else if (Platform.isAndroid) {
      return getDropdownButton();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 20.0, 18.0, 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CoinCard(
                  price: BTCprice,
                  currencyCoin: currencyCoin,
                  coinType: cryptoList[0],
                ),
                CoinCard(
                  price: ETHprice,
                  currencyCoin: currencyCoin,
                  coinType: cryptoList[1],
                ),
                CoinCard(
                  price: LTCprice,
                  currencyCoin: currencyCoin,
                  coinType: cryptoList[2],
                ),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: kContainerColor,
            child: getPicker(),
          ),
        ],
      ),
    );
  }
}

class CoinCard extends StatelessWidget {
  final price;
  final currencyCoin;
  final coinType;

  CoinCard(
      {@required this.price,
      @required this.currencyCoin,
      @required this.coinType});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kCardColor,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 45.0),
            child: Text(
              '1 $coinType = $price $currencyCoin',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
