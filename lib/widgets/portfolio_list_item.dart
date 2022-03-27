import 'package:flutter/material.dart';

import '../models/coin.dart';
import '../services/api_methods.dart';

ApiMethods _apiMethods = ApiMethods();

class PortfolioListItem extends StatefulWidget {
  final String name;
  final String buyPrice;
  final String quantity;
  final Coin coin;
  const PortfolioListItem({
    Key? key,
    required this.name,
    required this.buyPrice,
    required this.quantity,
    required this.coin,
  }) : super(key: key);

  @override
  State<PortfolioListItem> createState() => _PortfolioListItemState();
}

class _PortfolioListItemState extends State<PortfolioListItem> {
  @override
  Widget build(BuildContext context) {
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
                      backgroundColor: Colors.black,
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
                        style: TextStyle(
                          fontSize: 18,
                        ),
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
                        '\$${(double.parse(widget.quantity) * double.parse(widget.coin.price)).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '${widget.quantity} ${(widget.coin.symbol).toUpperCase()}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
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
                        '%${((double.parse(widget.coin.price) - double.parse(widget.buyPrice)) / double.parse(widget.buyPrice) * 100).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                          color: ((double.parse(widget.coin.price) -
                                          double.parse(widget.buyPrice)) /
                                      double.parse(widget.buyPrice) *
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
                        '\$${((double.parse(widget.coin.price) - double.parse(widget.buyPrice)) * double.parse(widget.quantity)).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                          color: ((double.parse(widget.coin.price) -
                                          double.parse(widget.buyPrice)) *
                                      double.parse(widget.quantity)) >
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
