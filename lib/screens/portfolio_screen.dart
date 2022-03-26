import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

import '../services/api_methods.dart';
import '../widgets/portfolio_list_item.dart';
import 'add_coin_screen.dart';
import '../models/coin.dart';
import '../widgets/total_portfolio_info.dart';

ApiMethods _apiMethods = ApiMethods();

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalInvested = 0.0;
    double currentValue = 0.0;

    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(top: 20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              FutureBuilder(
                future: _apiMethods.getCoinsList(),
                builder: (BuildContext context, AsyncSnapshot futureSnapshot) {
                  if (!futureSnapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    );
                  }

                  return Container(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .doc(FirebaseAuth.instance.currentUser?.uid)
                          .collection('Coins')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                        if (!streamSnapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          );
                        }

                        streamSnapshot.data!.docs.forEach((element) {
                          final Coin tempCoin = futureSnapshot.data
                              .firstWhere((coin) => coin.name == element.id);
                          totalInvested +=
                              double.parse(element.get('Quantity').toString()) *
                                  double.parse(element.get('Price').toString());
                          currentValue +=
                              double.parse(element.get('Quantity').toString()) *
                                  double.parse(tempCoin.price.toString());
                        });

                        return Column(
                          children: [
                            TotalPortfolioInfo(
                              totalInvested: totalInvested.toStringAsFixed(2),
                              currentValue: currentValue.toStringAsFixed(2),
                            ),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Your Assets',
                                  style: TextStyle(
                                    fontSize: 22,
                                  ),
                                ),
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: OpenContainer(
                                    transitionType:
                                        ContainerTransitionType.fadeThrough,
                                    closedColor: Colors.transparent,
                                    closedElevation: 0.0,
                                    openElevation: 4.0,
                                    transitionDuration:
                                        Duration(milliseconds: 1000),
                                    openBuilder: (BuildContext context,
                                            VoidCallback closeContainer) =>
                                        AddCoinScreen(),
                                    closedBuilder: (BuildContext _,
                                        VoidCallback openContainer) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Color(0XFF59B5B2),
                                          borderRadius:
                                              BorderRadius.circular(50),
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
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Coin',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Holdings',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Profit/Loss',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Divider(color: Colors.white),
                            ListView(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children:
                                  streamSnapshot.data!.docs.map((document) {
                                final Coin coin = futureSnapshot.data
                                    .firstWhere(
                                        (coin) => coin.name == document.id);
                                return Container(
                                  child: PortfolioListItem(
                                    name: document.id,
                                    buyPrice: document['Price'].toString(),
                                    quantity: document['Quantity'].toString(),
                                    coin: coin,
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
