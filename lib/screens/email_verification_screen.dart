import 'dart:async';

import 'package:ahsan_online_bazar/screens/add_product_screen.dart';
import 'package:ahsan_online_bazar/screens/dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {

  bool isEmailVerified = false;
  Timer? timer;


  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.currentUser!.sendEmailVerification();

    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
  }

  checkEmailVerified() {

    FirebaseAuth.instance.currentUser!.reload();

    if( FirebaseAuth.instance.currentUser!.emailVerified){
      setState(() {
        isEmailVerified = true;
      });
    }

    if( isEmailVerified){
      timer!.cancel();

      Fluttertoast.showToast(msg: 'Email Verified');
      // Go to Add Product Screen

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return const AddProductScreen();
      }));
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          const Text('Verify Email'),
          Text(
              'We have sent an email to ${FirebaseAuth.instance.currentUser!.email}'),
          const Text('Waiting for Verification'),
          const SizedBox(height: 16),
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: () {

            FirebaseAuth.instance.currentUser!.sendEmailVerification();


          }, child: const Text('Resend Email')),
        ],
      ),
    );
  }
}
