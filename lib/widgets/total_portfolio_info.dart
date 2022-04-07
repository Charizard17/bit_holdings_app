import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../providers/currency_provider.dart';

class TotalPortfolioInfo extends StatelessWidget {
  final String totalInvested;
  final String currentValue;
  final String usdtPrice;
  const TotalPortfolioInfo({
    Key? key,
    required this.totalInvested,
    required this.currentValue,
    required this.usdtPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizationsContext = AppLocalizations.of(context)!;
    final currencyProvider = Provider.of<CurrencyProvider>(context);

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
                appLocalizationsContext.portfolio,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    appLocalizationsContext.change,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '%${((double.parse(currentValue) - double.parse(totalInvested) * double.parse(usdtPrice)) / (double.parse(totalInvested) * double.parse(usdtPrice)) * 100).toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
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
                  Text(
                    appLocalizationsContext.investedAmount,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '${currencyProvider.currency == 'TRY' ? '₺' : currencyProvider.currency == 'EUR' ? '€' : '\$'} ${(double.parse(totalInvested) * double.parse(usdtPrice)).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize:
                            Theme.of(context).textTheme.titleSmall!.fontSize,
                        color: Theme.of(context).textTheme.titleSmall!.color,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    appLocalizationsContext.currentValue,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '${currencyProvider.currency == 'TRY' ? '₺' : currencyProvider.currency == 'EUR' ? '€' : '\$'} ${(double.parse(currentValue)).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize:
                            Theme.of(context).textTheme.titleSmall!.fontSize,
                        color: Theme.of(context).textTheme.titleSmall!.color,
                      ),
                    ),
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
