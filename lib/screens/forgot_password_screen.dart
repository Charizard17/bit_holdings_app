import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:email_validator/email_validator.dart';

import 'sign_in_screen.dart';
import '../services/flutterfire.dart';

FlutterFire _flutterFire = FlutterFire();

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appLocalizationsContext = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 50),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                appLocalizationsContext.forgotPasswordText,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 50),
              Container(
                color: Theme.of(context).primaryColorLight,
                padding: EdgeInsets.only(left: 15),
                child: TextFormField(
                  controller: _email,
                  decoration: InputDecoration(
                    hintText: 'example@email.com',
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                    errorStyle: TextStyle(
                      fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                  style: Theme.of(context).textTheme.bodyLarge,
                  validator: (email) =>
                      _email != null && !EmailValidator.validate(_email.text)
                          ? appLocalizationsContext.emailValidationText
                          : null,
                ),
              ),
              SizedBox(height: 20),
              MaterialButton(
                color: Theme.of(context).errorColor,
                child: Text(
                  appLocalizationsContext.resetPassword,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  final isValidForm = formKey.currentState!.validate();
                  if (isValidForm) {
                    await _flutterFire.resetPassword(_email.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Theme.of(context).errorColor,
                        content: Text(
                          appLocalizationsContext.resetPasswordEmailSent,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        duration: Duration(seconds: 2),
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
                    appLocalizationsContext.back,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) => SignInScreen(),
                      ),
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
