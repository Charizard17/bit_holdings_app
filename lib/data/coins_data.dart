import '../models/coin.dart';

class CoinsData {
  List<Coin> _coins = [];
  List<Coin> get coins => _coins;

  addCoins(Coin coin) {
    _coins.add(coin);
  }
}
