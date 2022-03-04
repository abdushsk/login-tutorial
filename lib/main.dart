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
      home: (FirebaseAuth.instance.currentUser != null)
          ? UserProfile()
          : LoginPage(),
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // FirebaseService service = new FirebaseService();
    return Scaffold(
      appBar: AppBar(
        title: Text("Login with google"),
      ),
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                try {
                  signInWithGoogle().then((value) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UserProfile(),
                    ));
                  });
                } catch (e) {
                  print(e);
                }
              },
              child: Text("Login With Google"))),
    );
  }
}

// ignore: use_key_in_widget_constructors
class UserProfile extends StatefulWidget {
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  User user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user.displayName!),
            Text(user.email!),
            ElevatedButton(
                onPressed: () {
                  signOutWithGoogle();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  }));
                },
                child: Text("Log out"))
          ],
        ),
      ),
    );
  }
}
