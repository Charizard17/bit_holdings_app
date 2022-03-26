import 'package:flutter/material.dart';

import '../services/api_methods.dart';

ApiMethods _apiMethods = ApiMethods();

class PortfolioListItem extends StatefulWidget {
  final String name;
  final String price;
  final String quantity;
  final String currentPrice;
  const PortfolioListItem({
    Key? key,
    required this.name,
    required this.price,
    required this.quantity,
    required this.currentPrice,
  }) : super(key: key);

  @override
  State<PortfolioListItem> createState() => _PortfolioListItemState();
}

class _PortfolioListItemState extends State<PortfolioListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '${widget.name}',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '${widget.quantity}',
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              '\$${(double.parse(widget.currentPrice) - double.parse(widget.price)) * double.parse(widget.quantity)}',
              style: TextStyle(
                fontSize: 18,
                color: ((double.parse(widget.currentPrice) -
                                double.parse(widget.price)) *
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
    );
  }
}
