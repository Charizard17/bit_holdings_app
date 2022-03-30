import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/coin.dart';
import '../services/api_methods.dart';

ApiMethods _apiMethods = ApiMethods();

class PortfolioListItem extends StatefulWidget {
  final String name;
  final String buyPrice;
  final String quantity;
  final String totalInvested;
  final Coin coin;
  const PortfolioListItem({
    Key? key,
    required this.name,
    required this.buyPrice,
    required this.quantity,
    required this.totalInvested,
    required this.coin,
  }) : super(key: key);

  @override
  State<PortfolioListItem> createState() => _PortfolioListItemState();
}

class _PortfolioListItemState extends State<PortfolioListItem> {
  @override
  Widget build(BuildContext context) {
    final formatCurrency = new NumberFormat.simpleCurrency();

    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColorLight,
                      radius: 15,
                      child: ClipOval(
                        child: Image.network(
                          widget.coin.image,
                          fit: BoxFit.cover,
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${widget.name}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '${formatCurrency.format(double.parse(widget.quantity) * double.parse(widget.coin.price))}',
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.right,
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '${widget.quantity} ${(widget.coin.symbol).toUpperCase()}',
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '%${((double.parse(widget.coin.price) * double.parse(widget.quantity) - double.parse(widget.totalInvested)) / double.parse(widget.totalInvested) * 100).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.bodySmall!.fontSize,
                          color: ((double.parse(widget.coin.price) *
                                              double.parse(widget.quantity) -
                                          double.parse(widget.totalInvested)) /
                                      double.parse(widget.totalInvested) *
                                      100) >
                                  0
                              ? Colors.green
                              : Colors.red,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '${formatCurrency.format(double.parse(widget.coin.price) * double.parse(widget.quantity) - double.parse(widget.totalInvested))}',
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.bodySmall!.fontSize,
                          color: (double.parse(widget.coin.price) *
                                          double.parse(widget.quantity) -
                                      double.parse(widget.totalInvested)) >
                                  0
                              ? Colors.green
                              : Colors.red,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
