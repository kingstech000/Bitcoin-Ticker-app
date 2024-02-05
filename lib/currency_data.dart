// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:http/http.dart';
import 'dart:convert';

class Currency {
  String BTC_url;
  String ETH_url;
  String LTC_url;
  Currency({required this.BTC_url, required this.ETH_url, required this.LTC_url});

  Future getBTC_currency() async {
    Response BTCresponse = await get(Uri.parse(BTC_url));
    if (BTCresponse.statusCode == 200) {
      String data = BTCresponse.body;
      var jsoncode = jsonDecode(data);
      print(data);
      print(jsoncode);
      return jsoncode;
    } else {
      print(BTCresponse.statusCode);
    }
  }

  Future getETH_currency() async {
    Response ETHresponse = await get(Uri.parse(ETH_url));
        if (ETHresponse.statusCode == 200) {
      String data = ETHresponse.body;
      var jsoncode = jsonDecode(data);
      print(data);
      print(jsoncode);
      return jsoncode;
    } else {
      print(ETHresponse.statusCode);
    }
  }

  Future getLTC_currency() async {
        Response LTCresponse = await get(Uri.parse(LTC_url));
        if (LTCresponse.statusCode == 200) {
      String data = LTCresponse.body;
      var jsoncode = jsonDecode(data);
      print(data);
      print(jsoncode);
      return jsoncode;
    } else {
      print(LTCresponse.statusCode);
    }
  }
}
