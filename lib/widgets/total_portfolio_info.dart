import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final appLocalizationsContext = AppLocalizations.of(context)!;
    final formatCurrency = new NumberFormat.simpleCurrency();

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
                      '%${((double.parse(currentValue) - double.parse(totalInvested)) / double.parse(totalInvested) * 100).toStringAsFixed(2)}',
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
                      '${formatCurrency.format(double.parse(totalInvested))}',
                      style: Theme.of(context).textTheme.titleSmall,
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
                      '${formatCurrency.format(double.parse(currentValue))}',
                      style: Theme.of(context).textTheme.titleSmall,
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
