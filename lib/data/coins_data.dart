import '../models/coin.dart';

class CoinsData {
  List _coins = [];

  List get coins => _coins;

  addCoins(Coin coin) {
    _coins.add(coin);
  }
}
