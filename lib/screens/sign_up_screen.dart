import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController nameC, mobileC, cityC, emailC, passC, confirmPassC;

  int gender = 1;

  bool passVisible = false;
  bool confirmPassVisible = false;

  @override
  void initState() {
    nameC = TextEditingController();
    mobileC = TextEditingController();
    cityC = TextEditingController();
    emailC = TextEditingController();
    passC = TextEditingController();
    confirmPassC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameC.dispose();
    mobileC.dispose();
    cityC.dispose();
    emailC.dispose();
    passC.dispose();
    confirmPassC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: nameC,
              decoration: const InputDecoration(
                  hintText: 'Name', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              keyboardType: TextInputType.number,
              controller: mobileC,
              maxLength: 11,
              decoration: const InputDecoration(
                  hintText: 'Mobile', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: cityC,
              decoration: const InputDecoration(
                  hintText: 'City', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailC,
              decoration: const InputDecoration(
                  hintText: 'Email', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passC,
              obscureText: passVisible,
              decoration:  InputDecoration(
                  suffixIcon: IconButton(onPressed: (){
                    setState(() {
                      passVisible = !passVisible;
                    });
                  }, icon: Icon(passVisible ?  Icons.visibility : Icons.visibility_off)),

                  hintText: 'Password', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: confirmPassC,
              obscureText: confirmPassVisible,
              decoration:  InputDecoration(
                  suffixIcon: IconButton(onPressed: (){
                    setState(() {
                      confirmPassVisible = !confirmPassVisible;
                    });
                  }, icon: Icon(confirmPassVisible ?  Icons.visibility : Icons.visibility_off)),
                  hintText: 'Confirm Password', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Row(
                  children: [
                    Radio(value: 1, groupValue: gender, onChanged: (value) {
                      setState(() {
                        gender = value!;
                      });
                    }),
                    const Text('Male'),
                  ],
                ),
                const Gap(20),
                Row(
                  children: [
                    Radio(value: 2, groupValue: gender, onChanged: (value) {
                      setState(() {
                        gender = value!;
                      });
                    }),
                    const Text('Female'),
                  ],
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                String name  = nameC.text.trim();

                if( name.isEmpty){
                  // Toast
                  Fluttertoast.showToast(msg: 'Please provide Name');
                  return;
                }

                String mobile = mobileC.text.trim();
                if( mobile.isEmpty){
                  Fluttertoast.showToast(msg: 'Please provide Mobile');
                  return;
                }

                if( mobile.length < 11 ){
                  Fluttertoast.showToast(msg: 'Please provide a Valid Mobile');
                  return;
                }

                String pass = passC.text.trim();
                String confirmPass = confirmPassC.text.trim();

                if( pass != confirmPass){
                  Fluttertoast.showToast(msg: 'Passwords do not match');
                  return;
                }
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
