import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'main_view.dart';
import 'forgot_password_screen.dart';
import 'sign_up_screen.dart';
import '../services/flutterfire.dart';

FlutterFire _flutterFire = FlutterFire();

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appLocalizationsContext = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              appLocalizationsContext.signIn,
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
                style: Theme.of(context).textTheme.bodyLarge,
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
                appLocalizationsContext.signIn,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              onPressed: () async {
                bool shouldNavigate =
                    await _flutterFire.signIn(_email.text, _password.text);
                if (shouldNavigate) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const MainView(),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 20),
            TextButton(
              child: Text(
                appLocalizationsContext.forgotPassword,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).focusColor,
                    ),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const ForgotPasswordScreen(),
                  ),
                );
              },
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       appLocalizationsContext.or,
            //       style: Theme.of(context).textTheme.bodyLarge,
            //     )
            //   ],
            // ),
            // SizedBox(height: 20),
            // Stack(
            //   children: [
            //     MaterialButton(
            //       color: Theme.of(context).focusColor,
            //       child: Text(
            //         appLocalizationsContext.signInWithGoogle,
            //         style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            //               fontWeight: FontWeight.bold,
            //             ),
            //       ),
            //       onPressed: () {},
            //     ),
            //     Positioned(
            //       top: 15,
            //       right: 0,
            //       child: RotationTransition(
            //         turns: AlwaysStoppedAnimation(30 / 360),
            //         child: Container(
            //           color: Theme.of(context).errorColor.withOpacity(0.5),
            //           child: Text(
            //             'Coming soon',
            //             style: TextStyle(
            //               color: Theme.of(context).primaryColor,
            //               fontSize: 10,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(height: 30),
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodySmall,
                children: [
                  TextSpan(
                      text: "${appLocalizationsContext.dontHaveAnAccount} "),
                  TextSpan(
                    text: appLocalizationsContext.signUp,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).focusColor,
                        ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const SignUpScreen(),
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
