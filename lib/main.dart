import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login/service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    FirebaseService service = new FirebaseService();
    return Scaffold(
      appBar: AppBar(
        title: Text("Login with google"),
      ),
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                try {
                  service.signInwithGoogle().then((value) {
                    print(FirebaseAuth.instance.currentUser);
                  });
                } catch (e) {
                  print(e);
                }
              },
              child: Text("Login With Google"))),
    );
  }
}
