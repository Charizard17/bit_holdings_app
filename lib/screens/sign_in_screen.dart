import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:email_validator/email_validator.dart';

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
  final formKey = GlobalKey<FormState>();
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
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
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
              SizedBox(height: 10),
              Container(
                color: Theme.of(context).primaryColorLight,
                padding: EdgeInsets.only(left: 15),
                child: TextFormField(
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
                    errorStyle: TextStyle(
                      fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                  style: Theme.of(context).textTheme.bodyLarge,
                  validator: (value) {
                    if (value != null && value.length < 8) {
                      return appLocalizationsContext.passwordValidationText;
                    } else {
                      return null;
                    }
                  },
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
                  final isValidForm = formKey.currentState!.validate();
                  if (isValidForm) {
                    await _flutterFire.signIn(_email.text, _password.text);
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
      ),
    );
  }
}
