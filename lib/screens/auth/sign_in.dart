import 'package:flutter/material.dart';
import 'package:user/components/action_button.dart';
import 'package:user/services/auth_service.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/background_login.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                margin: const EdgeInsets.only(left: 35, right: 35),
                child: Column(children: [
                  const Spacer(
                    flex: 5,
                  ),
                  ActionButton(
                    title: 'Sign in with Google',
                    onTap: () {
                      AuthService.signInWithGoogle();
                    },
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                ]),
              ),
            ),
    );
  }
}
