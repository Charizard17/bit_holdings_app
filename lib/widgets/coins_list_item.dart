import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/currency_provider.dart';

class CoinsListItem extends StatelessWidget {
  final String rank;
  final String name;
  final String symbol;
  final String image;
  final String price;
  final String priceChange24h;
  const CoinsListItem({
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
    final currencyProvider = Provider.of<CurrencyProvider>(context);

    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Theme.of(context).primaryColorLight,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              rank,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Expanded(
            flex: 2,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
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
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  symbol.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '$priceChange24h%',
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                color: double.parse(priceChange24h) >= 0
                    ? Colors.green
                    : Colors.red,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: FittedBox(
              alignment: Alignment.centerRight,
              fit: BoxFit.scaleDown,
              child: Text(
                '${currencyProvider.currency == 'TRY' ? '₺' : currencyProvider.currency == 'EUR' ? '€' : '\$'} ${price}',
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                  fontFamily: 'Roboto',
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
