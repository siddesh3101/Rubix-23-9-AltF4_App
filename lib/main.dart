import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisaankahaak/providers/auth_provider.dart';
import 'package:kisaankahaak/providers/location_provider.dart';
import 'package:kisaankahaak/screens/buy_crops_screen.dart';
import 'package:kisaankahaak/screens/dashboard_screen.dart';
import 'package:kisaankahaak/screens/retailer_dashboard.dart';
import 'package:kisaankahaak/screens/sell_crops_screen.dart';
import 'package:kisaankahaak/screens/splash_screen.dart';
import 'package:kisaankahaak/screens/timer.dart';
import 'package:kisaankahaak/screens/welcome_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'controllers/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Get.put(AuthController());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LocationProvider(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: SplashScreen(),
      initialRoute: SplashScreen.id,
      debugShowCheckedModeBanner: false,
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        DashBoardScreen.id: (context) => const DashBoardScreen(),
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        RetailerDashBoard.id: (context) => const RetailerDashBoard()
        // MapScreen.id: (context) => const MapScreen(),
      },
    );
  }
}
