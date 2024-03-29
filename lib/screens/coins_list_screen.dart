import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../widgets/coins_list_item.dart';
import '../services/api_methods.dart';
import '../providers/currency_provider.dart';

ApiMethods _apiMethods = ApiMethods();

class CoinsListScreen extends StatelessWidget {
  const CoinsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizationsContext = AppLocalizations.of(context)!;
    final currencyProvider = Provider.of<CurrencyProvider>(context);

    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(top: 20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      '#',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      appLocalizationsContext.coin,
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '${appLocalizationsContext.h24} %',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      appLocalizationsContext.price,
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Expanded(
                child: FutureBuilder(
                  future: _apiMethods.getCoinsList(currencyProvider.currency),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return CoinsListItem(
                          rank: snapshot.data[index].rank.toString(),
                          name: snapshot.data[index].name,
                          symbol: snapshot.data[index].symbol,
                          image: snapshot.data[index].image,
                          price: snapshot.data[index].price,
                          priceChange24h: snapshot.data[index].priceChange24h,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
