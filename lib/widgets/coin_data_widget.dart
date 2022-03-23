import 'package:flutter/material.dart';

class CoinDataWidget extends StatelessWidget {
  final String rank;
  final String name;
  final String symbol;
  final String image;
  final String price;
  final String priceChange24h;
  const CoinDataWidget({
    Key? key,
    required this.rank,
    required this.name,
    required this.symbol,
    required this.image,
    required this.price,
    required this.priceChange24h,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[700],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              rank,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: CircleAvatar(
              backgroundImage: NetworkImage(image),
              radius: 25,
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Text(
                  symbol.toUpperCase(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '$priceChange24h%',
              style: TextStyle(
                fontSize: 18,
                color: double.parse(priceChange24h) >= 0
                    ? Colors.greenAccent
                    : Colors.redAccent,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '\$ $price',
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
