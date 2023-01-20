import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kisaankahaak/screens/buy_crops_screen.dart';
import 'package:kisaankahaak/screens/dashboard_screen.dart';
import 'package:kisaankahaak/screens/signup_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../constants/mytheme.dart';
import '../constants/social_logins.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final forgotEmailController = TextEditingController();
  bool? isChecked = false;
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: MyTheme.splash,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          color: Colors.transparent,
          height: _size.height,
          width: _size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/kisaan.png",
                width: 70,
                height: 70,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  "Welcome Farmers,",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                "Login to get best price of crops",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                padding: const EdgeInsets.all(19),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: _size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Login to your account",
                      style: TextStyle(
                        fontSize: 16,
                        color: MyTheme.splash,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: TextFormField(
                        controller: emailController,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Username",
                          hintStyle: const TextStyle(color: Colors.black45),
                          fillColor: MyTheme.greyColor,
                          filled: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Password",
                          hintStyle: const TextStyle(color: Colors.black45),
                          fillColor: MyTheme.greyColor,
                          filled: true,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                          onPressed: () {
                            // Get.defaultDialog(
                            //   title: "Forgort Password?",
                            //   content: TextFormField(
                            //     style: const TextStyle(color: Colors.black),
                            //     controller: forgotEmailController,
                            //     decoration: InputDecoration(
                            //       border: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(5),
                            //         borderSide: BorderSide.none,
                            //       ),
                            //       hintText: "Email address",
                            //       hintStyle:
                            //           const TextStyle(color: Colors.black45),
                            //       fillColor: MyTheme.greyColor,
                            //       filled: true,
                            //     ),
                            //   ),
                            //   radius: 10,
                            //   onWillPop: () {
                            //     forgotEmailController.text = "";

                            //     return Future.value(true);
                            //   },
                            //   contentPadding: const EdgeInsets.symmetric(
                            //       horizontal: 20, vertical: 10),
                            //   confirm: ElevatedButton(
                            //     onPressed: () {
                            //       // AuthController.instance.forgorPassword(forgotEmailController.text.trim());
                            //       // forgotEmailController.text = "";
                            //       // Get.back();
                            //     },
                            //     style: ElevatedButton.styleFrom(
                            //       primary: MyTheme.splash,
                            //       shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(5),
                            //       ),
                            //     ),
                            //     child: const Center(
                            //       child: Padding(
                            //         padding: EdgeInsets.all(12),
                            //         child: Text(
                            //           "Send Reset Mail",
                            //           style: TextStyle(fontSize: 16),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: isChecked,
                                activeColor: Colors.green,
                                tristate: true,
                                onChanged: (value) {
                                  setState(() {
                                    isChecked = value;
                                  });
                                },
                              ),
                              Text(
                                "Are you a farmer",
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          )),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Get.defaultDialog(
                          //   title: "Forgort Password?",
                          //   content: TextFormField(
                          //     style: const TextStyle(color: Colors.black),
                          //     controller: forgotEmailController,
                          //     decoration: InputDecoration(
                          //       border: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(5),
                          //         borderSide: BorderSide.none,
                          //       ),
                          //       hintText: "Email address",
                          //       hintStyle:
                          //           const TextStyle(color: Colors.black45),
                          //       fillColor: MyTheme.greyColor,
                          //       filled: true,
                          //     ),
                          //   ),
                          //   radius: 10,
                          //   onWillPop: () {
                          //     forgotEmailController.text = "";

                          //     return Future.value(true);
                          //   },
                          //   contentPadding: const EdgeInsets.symmetric(
                          //       horizontal: 20, vertical: 10),
                          //   confirm: ElevatedButton(
                          //     onPressed: () {
                          //       // AuthController.instance.forgorPassword(forgotEmailController.text.trim());
                          //       // forgotEmailController.text = "";
                          //       // Get.back();
                          //     },
                          //     style: ElevatedButton.styleFrom(
                          //       primary: MyTheme.splash,
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(5),
                          //       ),
                          //     ),
                          //     child: const Center(
                          //       child: Padding(
                          //         padding: EdgeInsets.all(12),
                          //         child: Text(
                          //           "Send Reset Mail",
                          //           style: TextStyle(fontSize: 16),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // );
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // isChecked!
                        //     ? Navigator.push(
                        //         context,
                        //         PageTransition(
                        //           child: const DashBoardScreen(),
                        //           type: PageTransitionType.fade,
                        //         ),
                        //       )
                        //     : Navigator.push(
                        //         context,
                        //         PageTransition(
                        //           child: const BuyCrops(),
                        //           type: PageTransitionType.fade,
                        //         ),
                        //       );
                        AuthController.instance.login(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                            isChecked);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyTheme.splash,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            "LOGIN",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              "Or",
                              style: TextStyle(color: Color(0xFFC1C1C1)),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: SocialLoginButtons(
                        onFbClick: () {},
                        onGoogleClick: () {
                          AuthController.instance.googleLogin();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Don’t have an account ? ",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    TextSpan(
                      text: "Sign up",
                      style: const TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w700),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          //Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpScreen()));
                          Get.to(const SignUpScreen());
                        },
                    ),
                    const TextSpan(
                      text: " here.",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
