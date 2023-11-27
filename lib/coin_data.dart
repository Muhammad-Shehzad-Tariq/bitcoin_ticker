// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'dart:convert';
import 'package:bitcoin_ticker/price_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'PKR',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];
String? currentCurrency(int i) {
  for (String code in currenciesList) {
    String value = code[i];
    return value;
    print(value);
  }
}

Padding cards(String crypto, String comCurrency, String comCurrencynum,
    Widget cryptoIcon) {
  return Padding(
    padding: EdgeInsets.fromLTRB(18.0, 18, 18.0, 0),
    child: Card(
      color: Colors.lightBlue,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.circular(
          10.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              cryptoIcon,
              Text(
                '$crypto = $comCurrency',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              '$comCurrencynum',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

const coinAPIURL = 'https://api.currencybeacon.com/v1/convert';
const apiKey = 'gylShjD82dUOjcncLtmDCFGlAdYkRGgy';
PriceScreen currency = PriceScreen();

class CoinData {
  Future getCoinData(int currency, String currency1) async {
    try {
      http.Response response = await http.get(
        Uri.parse(
            'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=$currency&limit=1&convert=$currency1&CMC_PRO_API_KEY=8a81433e-1bcb-465f-886e-95c9dd140608'),
      );

      var data = jsonDecode(response.body);
      double num = data['data'][0]['quote']['$currency1']['price'];
      return num;
    } catch (e) {
      print('your exception is $e');
    }
  }
}
