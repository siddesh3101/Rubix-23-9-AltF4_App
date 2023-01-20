import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kisaankahaak/screens/dashboard_screen.dart';
import 'package:kisaankahaak/screens/login_screen.dart';
import 'package:kisaankahaak/screens/onboarding_screen.dart';
import 'package:kisaankahaak/screens/retailer_dashboard.dart';
import 'package:kisaankahaak/screens/welcome_screen.dart';

import '../constants/mytheme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String id = 'splash-scren';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final CollectionReference profileList =
      FirebaseFirestore.instance.collection('users');
  late AnimationController _animationController;
  late Animation<double> _animation;
  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _animation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceOut,
        reverseCurve: Curves.bounceIn);
    _animationController.forward();
    Timer(const Duration(seconds: 3), () {
      FirebaseAuth.instance.authStateChanges().listen((User? user) async {
        if (user == null) {
          Navigator.pushReplacementNamed(
            context,
            WelcomeScreen.id,
          );
        } else {
          final docUser = profileList.doc(user.uid);
          final snapshot = await docUser.get();
          var data = snapshot.data() as Map;
          // var _list = data.values.toList();
          data["status"] == true
              ? Navigator.pushReplacementNamed(context, DashBoardScreen.id)
              : Navigator.pushReplacementNamed(context, RetailerDashBoard.id);
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.splash,
      // body: Center(
      //     child: Expanded(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       Text(
      //         "Hi",
      //         style: TextStyle(
      //             fontSize: 22,
      //             fontWeight: FontWeight.bold,
      //             color: Colors.black),
      //       )
      //     ],
      //   ),
      // )),
      body: Column(
        children: [
          SizedBox(
            height: 300,
          ),
          Container(
            child: Center(
              child: ScaleTransition(
                  scale: _animation,
                  child: Image.asset(
                    "assets/kisaan.png",
                    width: 80,
                    height: 80,
                  )),
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Text(
            "Kisaan Seva",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40),
          )
        ],
      ),
    );
  }
}
