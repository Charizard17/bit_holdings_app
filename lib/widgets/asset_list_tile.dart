import 'package:flutter/material.dart';

class AssetListTile extends StatelessWidget {
  final String name;
  final String symbol;
  final Color iconColor;
  final String profitLossPercent;
  final Color profitLossColor;
  const AssetListTile({
    Key? key,
    required this.name,
    required this.symbol,
    required this.iconColor,
    required this.profitLossPercent,
    required this.profitLossColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: iconColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name),
                    Text(symbol),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('\$7,000.00'),
              Text('B0.18'),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: profitLossColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(profitLossPercent),
          ),
        ],
      ),
    );
  }
}
