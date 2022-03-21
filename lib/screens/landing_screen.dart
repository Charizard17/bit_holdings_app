import 'package:flutter/material.dart';

import 'sign_in_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(vertical: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create your portfolio',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Explore new market pairs',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Follow latest news',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
              ),
            ),
            MaterialButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                'Get Started',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const SignInScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
