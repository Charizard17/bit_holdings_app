import 'dart:convert';

import 'package:http/http.dart' as http;

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

Future<bool> getCoinsList() async {
  try {
    var url = Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=10');
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    print(json);
    return true;
  } catch (e) {
    print(e.toString());
    return false;
  }
}
