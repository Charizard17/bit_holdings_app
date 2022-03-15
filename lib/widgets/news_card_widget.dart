import 'package:flutter/material.dart';

class NewsCardWidget extends StatelessWidget {
  final String title;
  final String bodyText;
  final Color placeholderColor;
  const NewsCardWidget({
    Key? key,
    required this.title,
    required this.bodyText,
    required this.placeholderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      height: MediaQuery.of(context).size.height / 5,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: (MediaQuery.of(context).size.width - 50) / 2.2,
                height: 80,
                child: Text(
                  bodyText,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              Container(
                width: (MediaQuery.of(context).size.width - 50) / 2.2,
                height: 80,
                decoration: BoxDecoration(
                  color: placeholderColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
