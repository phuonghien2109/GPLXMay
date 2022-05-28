import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:user/providers/quiz_provider.dart';
import 'package:user/screens/auth/sign_in.dart';
import 'package:user/screens/home/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (_) => QuizProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user == null) {
        setState(() {
          _isLoggedIn = false;
        });
        return;
      }

      setState(() {
        _isLoggedIn = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hajir Jawaf',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: (_isLoggedIn ?? false) ? const HomePage() : const SignIn(),
      ),
    );
  }
}
