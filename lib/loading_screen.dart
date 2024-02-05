// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'currency_data.dart';
import 'price_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getCoindata();
  }

  Future getCoindata() async {
    Currency mycurrency = Currency(
        BTC_url:
            "https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=be7b3526-8e18-41ec-a3a7-33eba35296bc",
        ETH_url:
            "https://rest.coinapi.io/v1/exchangerate/ETH/USD?apikey=be7b3526-8e18-41ec-a3a7-33eba35296bc",
        LTC_url:
            "https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=be7b3526-8e18-41ec-a3a7-33eba35296bc");
    var BTCdata = await mycurrency.getBTC_currency();
    var ETHdata = await mycurrency.getETH_currency();
    var LTCdata = await mycurrency.getLTC_currency();
    double BTCprice = await BTCdata['rate'];
    double ETHprice = await ETHdata['rate'];
    double LTCprice = await LTCdata['rate'];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PriceScreen(btcprice: BTCprice, ethprice: ETHprice, ltcprice: LTCprice,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitDoubleBounce(
        size: 100,
        color: Colors.blue,
      ),
    );
  }
}
