import 'package:crypto_portfolio_tracker/widgets/news_card_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Text(
              'Latest Quick News',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 20),
            Container(
              height: 500,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    NewsCardWidget(
                      title: 'Title of the news',
                      bodyText:
                          'lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem',
                      placeholderColor: Colors.blue,
                    ),
                    NewsCardWidget(
                      title: 'Title of the news 2',
                      bodyText:
                          'lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem',
                      placeholderColor: Colors.red,
                    ),
                    NewsCardWidget(
                      title: 'Title of the news 3',
                      bodyText:
                          'lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem',
                      placeholderColor: Colors.green,
                    ),
                    NewsCardWidget(
                      title: 'Title of the news 4',
                      bodyText:
                          'lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem',
                      placeholderColor: Colors.yellow,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
