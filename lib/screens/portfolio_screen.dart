import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

import '../widgets/asset_list_tile.dart';
import 'add_coin_screen.dart';
import 'screens.dart';
import '../widgets/widgets.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(top: 20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                // height: 150,
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
                              '%126.15',
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
                              '\$6,500.00',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Holding Value'),
                            Text(
                              '\$14,700.07',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Assets',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    width: 35,
                    height: 35,
                    child: OpenContainer(
                      transitionType: ContainerTransitionType.fadeThrough,
                      closedColor: Colors.transparent,
                      closedElevation: 0.0,
                      openElevation: 4.0,
                      transitionDuration: Duration(milliseconds: 1000),
                      openBuilder: (BuildContext context, VoidCallback closeContainer) =>
                          AddCoinScreen(),
                      closedBuilder:
                          (BuildContext _, VoidCallback openContainer) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Color(0XFF59B5B2),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(Icons.add),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Coin'),
                  Text('Holdings'),
                  Text('Profit/Loss'),
                ],
              ),
              Divider(color: Colors.white),
              Container(
                height: 350,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AssetListTile(
                        name: 'Bitcoin',
                        symbol: 'BTC',
                        iconColor: Colors.orangeAccent,
                        profitLossPercent: '%1.05',
                        profitLossColor: Colors.green,
                      ),
                      Divider(color: Colors.white),
                      AssetListTile(
                        name: 'Ethereum',
                        symbol: 'ETH',
                        iconColor: Colors.blue,
                        profitLossPercent: '%-1.05',
                        profitLossColor: Colors.red,
                      ),
                      Divider(color: Colors.white),
                      AssetListTile(
                        name: 'Litecoin',
                        symbol: 'LTC',
                        iconColor: Colors.grey,
                        profitLossPercent: '%5.67',
                        profitLossColor: Colors.green,
                      ),
                      Divider(color: Colors.white),
                      AssetListTile(
                        name: 'XRP',
                        symbol: 'XRP',
                        iconColor: Colors.black54,
                        profitLossPercent: '%-7.14',
                        profitLossColor: Colors.red,
                      ),
                      Divider(color: Colors.white),
                      AssetListTile(
                        name: 'PAXG',
                        symbol: 'PAXG',
                        iconColor: Colors.orange,
                        profitLossPercent: '%+17.14',
                        profitLossColor: Colors.green,
                      ),
                      Divider(color: Colors.white),
                      AssetListTile(
                        name: 'Dogecoin',
                        symbol: 'DOGE',
                        iconColor: Colors.yellowAccent,
                        profitLossPercent: '%-20.00',
                        profitLossColor: Colors.red,
                      ),
                      Divider(color: Colors.white),
                      AssetListTile(
                        name: 'Waves',
                        symbol: 'Waves',
                        iconColor: Colors.blueAccent,
                        profitLossPercent: '%-2.50',
                        profitLossColor: Colors.red,
                      ),
                      Divider(color: Colors.white),
                      AssetListTile(
                        name: 'x8currency',
                        symbol: 'X8X',
                        iconColor: Colors.yellow,
                        profitLossPercent: '%60.50',
                        profitLossColor: Colors.green,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
