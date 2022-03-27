import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'sign_in_screen.dart';
import '../services/flutterfire.dart';

FlutterFire _flutterFire = FlutterFire();

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sign Up',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 20),
            Container(
              color: Theme.of(context).primaryColorLight,
              padding: EdgeInsets.only(left: 15),
              child: TextField(
                controller: _email,
                decoration: InputDecoration(
                  hintText: 'example@email.com',
                  hintStyle: Theme.of(context).textTheme.bodyLarge,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                ),
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              color: Theme.of(context).primaryColorLight,
              padding: EdgeInsets.only(left: 15),
              child: TextField(
                controller: _password,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'password',
                  hintStyle: Theme.of(context).textTheme.bodyLarge,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                ),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            SizedBox(height: 20),
            MaterialButton(
              color: Theme.of(context).focusColor,
              child: Text(
                'Sign Up',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                bool shouldNavigate =
                    await _flutterFire.signUp(_email.text, _password.text);
                if (shouldNavigate) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const SignInScreen(),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 30),
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodySmall,
                children: [
                  TextSpan(text: 'Already have an account? '),
                  TextSpan(
                    text: 'Sign In',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).focusColor,
                        ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const SignInScreen(),
                          ),
                        );
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
