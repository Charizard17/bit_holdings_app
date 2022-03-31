import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../services/api_methods.dart';
import '../services/flutterfire.dart';
import '../widgets/portfolio_list_item.dart';
import 'add_coin_screen.dart';
import '../models/coin.dart';
import '../widgets/total_portfolio_info.dart';

ApiMethods _apiMethods = ApiMethods();
FlutterFire _flutterFire = FlutterFire();

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

                        double totalInvested = 0.0;
                        double currentValue = 0.0;

                        streamSnapshot.data!.docs.forEach((document) {
                          final Coin tempCoin = futureSnapshot.data.firstWhere(
                              (coin) =>
                                  coin.name ==
                                  document.id.replaceAll('-', ' '));
                          totalInvested += double.parse(
                              document.get('TotalInvested').toString());
                          currentValue += double.parse(
                                  document.get('Quantity').toString()) *
                              double.parse(tempCoin.price.toString());
                        });

                        return TotalPortfolioInfo(
                          totalInvested: totalInvested.toStringAsFixed(2),
                          currentValue: currentValue.toStringAsFixed(2),
                        );
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Assets',
                    style: Theme.of(context).textTheme.titleSmall,
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
                      openBuilder:
                          (BuildContext context, VoidCallback closeContainer) =>
                              AddCoinScreen(),
                      closedBuilder:
                          (BuildContext _, VoidCallback openContainer) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Color(0XFF59B5B2),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            Icons.add,
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color,
                          ),
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
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Holdings',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Profit/Loss',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Divider(
                color: Theme.of(context).textTheme.bodyMedium!.color,
                thickness: 1,
              ),
              Expanded(
                child: FutureBuilder(
                  future: _apiMethods.getCoinsList(),
                  builder:
                      (BuildContext context, AsyncSnapshot futureSnapshot) {
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

                          return ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: streamSnapshot.data!.docs.map((document) {
                              final Coin coin = futureSnapshot.data.firstWhere(
                                  (coin) =>
                                      coin.name ==
                                      document.id.replaceAll('-', ' '));
                              return Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 13),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1,
                                        color: Theme.of(context)
                                            .primaryColorLight),
                                  ),
                                ),
                                child: Slidable(
                                  endActionPane: ActionPane(
                                    motion: ScrollMotion(),
                                    children: [
                                      Expanded(child: Container()),
                                      OutlinedButton.icon(
                                        style: OutlinedButton.styleFrom(
                                          side: BorderSide(
                                            width: 2.0,
                                            color: Colors.red,
                                          ),
                                        ),
                                        label: Text(
                                          'Delete Tx',
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.red),
                                        ),
                                        icon: Icon(
                                          Icons.delete_outline_rounded,
                                          color: Colors.red,
                                        ),
                                        onPressed: () async {
                                          await _flutterFire
                                              .deleteCoin(document.id);
                                        },
                                      ),
                                    ],
                                  ),
                                  child: PortfolioListItem(
                                    name: document.id,
                                    buyPrice: document['Price'].toString(),
                                    quantity: document['Quantity'].toString(),
                                    totalInvested:
                                        document['TotalInvested'].toString(),
                                    coin: coin,
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
