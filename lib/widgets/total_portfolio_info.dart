import 'package:flutter/material.dart';

class TotalPortfolioInfo extends StatelessWidget {
  final String totalInvested;
  final String currentValue;
  const TotalPortfolioInfo({
    Key? key,
    required this.totalInvested,
    required this.currentValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0XFF59B5B2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Portfolio',
                style: Theme.of(context).textTheme.headline5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Change'),
                  Text(
                    '%${((double.parse(currentValue) - double.parse(totalInvested))/double.parse(totalInvested)*100).toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Invested Amount'),
                  Text(
                    '\$${totalInvested}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Current Value'),
                  Text(
                    '\$${currentValue}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
