import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/coin.dart';
import '../data/coins_data.dart';

CoinsData _coinsData = CoinsData();

class ApiMethods {
  Future<double> getPrice(String id) async {
    try {
      var url = Uri.parse('https://api.coingecko.com/api/v3/coins/$id');
      var response = await http.get(url);
      var json = jsonDecode(response.body);
      var value = json['market_data']['current_price']['usd'].toString();
      return double.parse(value);
    } catch (e) {
      print(e.toString());
      return 0.0;
    }
  }

  Future<List<Coin>> getCoinsList() async {
    try {
      var url = Uri.parse(
          'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1');
      var response = await http.get(url);
      var json = jsonDecode(response.body);
      for (var coin in json) {
        Coin aCoin = Coin(
          coin['market_cap_rank'],
          coin['name'],
          coin['symbol'],
          coin['current_price'].toString(),
          double.parse(coin['price_change_percentage_24h'].toString())
              .toStringAsFixed(2),
          coin['image'],
        );
        _coinsData.addCoins(aCoin);
      }
      return _coinsData.coins;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
