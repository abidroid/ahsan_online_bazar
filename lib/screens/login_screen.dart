import 'package:ahsan_online_bazar/screens/dashboard_screen.dart';
import 'package:ahsan_online_bazar/screens/email_verification_screen.dart';
import 'package:ahsan_online_bazar/screens/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailC, passC;

  @override
  void initState() {
    emailC = TextEditingController();
    passC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailC.dispose();
    passC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: emailC,
              decoration: const InputDecoration(
                  hintText: 'Email', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passC,
              obscureText: true,
              decoration: const InputDecoration(
                  hintText: 'Password', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                String email = emailC.text.trim();
                String pass = passC.text.trim();

                print(email);
                print(pass);
                try {
                  UserCredential? userCredential =
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email,
                    password: pass,
                  );

                  if (userCredential.user != null) {

                    // check if email is verified
                    // if not go to verification screen

                    if( FirebaseAuth.instance.currentUser!.emailVerified){
                      // go to dashboard screen

                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const DashboardScreen();
                      }));

                    }else{

                      // go to dashboard screen

                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const EmailVerificationScreen();
                      }));
                    }





                  }
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    Fluttertoast.showToast(msg: 'User not found');
                  } else if (e.code == 'wrong-password') {
                    Fluttertoast.showToast(msg: 'Wrong password');
                  }
                }
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Forgot Password'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const SignUpScreen();
                  }));
                },
                child: const Text('Not Registered Yet ? Register Now'))
          ],
        ),
      ),
    );
  }
}
