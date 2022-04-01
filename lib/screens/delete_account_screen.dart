import 'package:bit_holdings_app/screens/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'sign_in_screen.dart';
import '../services/flutterfire.dart';

FlutterFire _flutterFire = FlutterFire();

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({Key? key}) : super(key: key);

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
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
              appLocalizationsContext.deleteAccount,
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
              color: Theme.of(context).errorColor,
              child: Text(
                appLocalizationsContext.deleteAccount,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                await _flutterFire.deleteUser(_email.text, _password.text);
                bool shouldNavigate = await _flutterFire.signOut();
                if (shouldNavigate) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const SignInScreen(),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 50),
            Container(
              child: MaterialButton(
                color: Theme.of(context).focusColor,
                child: Text(
                  appLocalizationsContext.nevermind,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => MainView(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
