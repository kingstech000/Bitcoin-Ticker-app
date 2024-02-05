// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'currency_data.dart';

class PriceScreen extends StatefulWidget {
  final double btcprice;
  final double ethprice;
  final double ltcprice;
  const PriceScreen(
      {super.key,
      required this.btcprice,
      required this.ethprice,
      required this.ltcprice});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  DropdownButton<String> getAndroidDropdown() {
    List<DropdownMenuItem<String>> dropdown = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
      dropdown.add(newItem);
    }
    return DropdownButton<String>(
        value: selectedText,
        items: dropdown,
        onChanged: (value) {
          setState(() {
            selectedText = value;
            updateUi();
          });
        });
  }

  CupertinoPicker getIosPicker() {
    List<Widget> pickerMenu = [];
    for (String currency in currenciesList) {
      var newPickerItem = Text(currency);
      pickerMenu.add(newPickerItem);
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: (value) {
        selectedText = currenciesList[value];
        updateUi();
      },
      children: pickerMenu,
    );
  }

  String? selectedText = "USD";
  double? BTCprice = 0;
  double? ETHprice = 0;
  double? LTCprice = 0;
  bool iswaiting = false;

  void updateUi() async {
    iswaiting = true;
    Currency mycurrency = Currency(
        BTC_url:
            "https://rest.coinapi.io/v1/exchangerate/BTC/$selectedText?apikey=be7b3526-8e18-41ec-a3a7-33eba35296bc",
        ETH_url:
            "https://rest.coinapi.io/v1/exchangerate/ETH/$selectedText?apikey=be7b3526-8e18-41ec-a3a7-33eba35296bc",
        LTC_url:
            "https://rest.coinapi.io/v1/exchangerate/LTC/$selectedText?apikey=be7b3526-8e18-41ec-a3a7-33eba35296bc");
    try {
      iswaiting = false;
      var BTCdata = await mycurrency.getBTC_currency();
      var ETHdata = await mycurrency.getETH_currency();
      var LTCdata = await mycurrency.getLTC_currency();
      setState(() async {
        BTCprice = await BTCdata['rate'];
        ETHprice = await ETHdata['rate'];
        LTCprice = await LTCdata['rate'];
      });
    } catch (e) {
      print(e);
    }
    print(BTCprice);
    print(ETHprice);
    print(LTCprice);
    print(selectedText);
  }

  Widget getMenu() {
    if (Platform.isIOS) {
      return getIosPicker();
    } else {
      return getAndroidDropdown();
    }
  }

  @override
  void initState() {
    iswaiting = false;
    BTCprice = widget.btcprice;
    ETHprice = widget.ethprice;
    LTCprice = widget.ltcprice;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('🤑 Coin Ticker'),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: CurrencyCard(
              price: iswaiting ? '?' : BTCprice?.toStringAsFixed(0),
              selectedText: selectedText,
              coin: "BTC",
              coinTitle: "bitcoin",
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: CurrencyCard(
              price: iswaiting ? '?' : ETHprice?.toStringAsFixed(0),
              selectedText: selectedText,
              coin: "ETH",
              coinTitle: "ethereum",
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: CurrencyCard(
              price: iswaiting ? '?' : LTCprice?.toStringAsFixed(0),
              selectedText: selectedText,
              coin: "LTC",
              coinTitle: "litecoin",
            ),
          ),
          SizedBox(
            height: 350,
          ),
          Container(
            height: 150.0,
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getMenu(),
          ),
        ],
      ),
    );
  }
}

class CurrencyCard extends StatelessWidget {
  const CurrencyCard({
    super.key,
    required this.price,
    required this.selectedText,
    required this.coin,
    required this.coinTitle,
  });

  final String? price;
  final String? selectedText;
  final String? coin;
  final String? coinTitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $coin = $price $selectedText',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),
    );
  }
}
