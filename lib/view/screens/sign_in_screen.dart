import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';
import '../../services/database.dart';
import '../../services/helper_function.dart';
import '../widgets/widget.dart';

class SignInScreen extends StatefulWidget {
  final Function toggle;
  SignInScreen(this.toggle);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String? errorMessage = '';

  GlobalKey<FormState> key = GlobalKey<FormState>();
  Auth auth = Auth();
  DatabaseMethods databaseMethods = DatabaseMethods();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  QuerySnapshot? snapshotUserInfo;
  // SignIn() {
  //   if (key.currentState!.validate()) {
  //     HelperFunctions.saveUserEmailSharedPreference(emailController.text);
  //     databaseMethods.getUserByUserEmail(emailController.text).then((val) {
  //       snapshotUserInfo = val;
  //       HelperFunctions.saveUserNameSharedPreference(
  //           snapshotUserInfo!.docs[0]["name"]);
  //     });
  //
  //     setState(() {
  //       isLoading = true;
  //     });
  //
  //     auth
  //         .signInWithEmailAndPassword(
  //             email: emailController.text, password: passwordController.text)
  //         .then((val) {
  //       HelperFunctions.saveUserLoggedInSharedPreference(true);
  //       Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (context) => BottomNavBar()));
  //     });
  //   }
  // }

  // MongoDB NoSql
  // ModeJs
  // FCM firebase cloud messaging (Push notification)
  // Dynamic link / Deep link
  // Authentication - NativeSDK
  // Method Channel top level flutter
  // Tracking google maps
  // web socket / Io Socket
  // Socket

  // Future<void> signInWithEmailAndPassword() async {
  //   try {
  //     await Auth().signInWithEmailAndPassword(
  //       email: emailController.text,
  //       password: passwordController.text,
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     setState(() {
  //       errorMessage = e.message;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Form(
            key: key,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Sign In',
                        style: customTextTitle(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Sign In now if you have already account',
                        style: customText(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  TextFormField(
                    validator: (val) {
                      return RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val!)
                          ? null
                          : "Enter correct email";
                    },
                    controller: emailController,
                    style: customText(),
                    decoration: customTextField('Email'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (String? val) {
                      RegExp reg = RegExp(
                          r'''(?=(.*[0-9]))(?=.*[\!@#$%^&*()\\[\]{}\-_+=~`|:;"'<>,./?])(?=.*[a-z])(?=(.*[A-Z]))(?=(.*)).{8,}''');
                      if (!reg.hasMatch(val!)) {
                        return 'Enter Validate Password';
                      }
                      return null;
                    },
                    controller: passwordController,
                    style: customText(),
                    decoration: customTextField('Password'),
                  ),
                  Text(errorMessage == '' ? '' : 'Hum ? $errorMessage'),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: const Text(
                        'Forget Password?',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: () {
                      if (key.currentState!.validate()) {
                        auth
                            .signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        )
                            .then((val) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BottomNavBar()));
                        });
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          color: const Color(0xff03d399),
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        'Sign In',
                        style: buttonText(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have account? ",
                        style: customText(),
                      ),
                      GestureDetector(
                        onTap: () {
                          widget.toggle();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'SignUp',
                            style: textBtn(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
