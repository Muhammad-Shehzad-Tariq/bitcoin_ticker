// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, unnecessary_new, use_key_in_widget_constructors, library_private_types_in_public_api, unnecessary_string_interpolations, sort_child_properties_last

import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? selectedCurrency = 'USD';

  CoinData coindata = CoinData();
  String? bitCoin;
  String? etheReum;
  String? liteCoin;
  Future showData(String currency) async {
    var btc = await coindata.getCoinData(1, currency);
    var eth = await coindata.getCoinData(2, currency);
    var ltc = await coindata.getCoinData(18, currency);
    setState(() {
      bitCoin = btc.toStringAsFixed(2);
      etheReum = eth.toStringAsFixed(2)!;
      liteCoin = ltc.toStringAsFixed(2);
    });
  }

  DropdownButton dropDown() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String curreny in currenciesList) {
      var netItem = DropdownMenuItem(
        child: Text('$curreny'),
        value: curreny,
      );
      dropDownItems.add(netItem);
    }
    return DropdownButton<String>(
      dropdownColor: Colors.lightBlue,
      value: selectedCurrency,
      items: dropDownItems,
      onChanged: (String? value) {
        setState(
          () {
            selectedCurrency = value;
            print(selectedCurrency);
            showData(selectedCurrency!);
          },
        );
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Text> pickerItem = [];
    for (String curreny in currenciesList) {
      var list = Text(curreny);
      pickerItem.add(list);
    }
    return CupertinoPicker(
        itemExtent: 32,
        onSelectedItemChanged: (value) {
          value;
          selectedCurrency = currenciesList[value];
          print(selectedCurrency);
          showData(selectedCurrency!);
        },
        children: pickerItem);
  }

  @override
  void initState() {
    super.initState();
    //14. Call getData() when the screen loads up. We can't call CoinData().getCoinData() directly here because we can't make initState() async.
    showData(selectedCurrency!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Center(child: Text('🤑 Coin Ticker')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Column(
              children: [
                cards(
                  'BTC',
                  selectedCurrency!,
                  '$bitCoin',
                  IconButton(
                    onPressed: () {},
                    icon: new Icon(CryptoFontIcons.BTC),
                  ),
                ),
                cards(
                  'ETH',
                  selectedCurrency!,
                  '$etheReum',
                  IconButton(
                    onPressed: () {},
                    icon: new Icon(CryptoFontIcons.ETH),
                  ),
                ),
                cards(
                  'LTC',
                  selectedCurrency!,
                  '$liteCoin',
                  IconButton(
                    onPressed: () {},
                    icon: new Icon(CryptoFontIcons.LTC),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
                height: 150.0,
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 30.0),
                color: Colors.lightBlue,
                child: Platform.isIOS ? iosPicker() : dropDown()),
          ),
        ],
      ),
    );
  }
}
