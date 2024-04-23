import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: 'your-client_id.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        if (googleSignInAccount.email.endsWith('@thapar.edu')) {
          print('Signed in successfully.');
        } else {
          await _googleSignIn.signOut();
          print('Only thapar.edu email addresses are allowed.');
        }
      }
    } catch (error) {
      print(error);
    }
  }

  bool isGoogleLoggedIn() {
    return _googleSignIn.currentUser != null;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.only(top: height / 3)),
              Container(
                width: width,
                child: Center(
                  child: Text(
                    "Google Sign in",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: ElevatedButton(
                    onPressed: _handleSignIn,
                    child: Container(
                      width: width / 4,
                      child: Row(
                        children: [Icon(Icons.login), Text("Log in")],
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
