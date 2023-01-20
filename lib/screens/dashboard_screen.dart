import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kisaankahaak/controllers/auth_controller.dart';
import 'package:kisaankahaak/screens/crop_education.dart';
import 'package:kisaankahaak/screens/crop_history.dart';
import 'package:kisaankahaak/screens/market_maps.dart';
import 'package:kisaankahaak/screens/sell_crops_screen.dart';
import 'package:kisaankahaak/screens/welcome_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/location_provider.dart';
import 'buy_crops_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});
  static const String id = 'dashboard-screen';

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final databaseref = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final locationData = Provider.of<LocationProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: Container(
          padding: EdgeInsets.only(top: 70, left: 20, right: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'FRIDAY, 20 JAN',
                        style: TextStyle(
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        'Good Morning, Ramesh',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  CircleAvatar(
                    maxRadius: 15,
                    child: Image.asset('assets/farmer.png'),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Container(
                    height: 35,
                    width: 280,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Search',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () {
                      // AuthController.instance.signOut();
                      auth.error = '';

                      FirebaseAuth.instance.signOut().then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WelcomeScreen(),
                            ));
                      });
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.logout),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 30, right: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // color: Colors.red,

                  height: 150,
                  child: Stack(
                    children: [
                      Image.asset('assets/Rectangle 2.png'),
                      Padding(
                        padding: EdgeInsets.only(top: 18, left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Freshfood from farm',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'Easy to pick your food!',
                              style: TextStyle(
                                color: Color(0xffE2E2E2),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: const SellCrops(),
                            type: PageTransitionType.fade,
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 248, 247, 247),
                            borderRadius: BorderRadius.circular(20)),
                        width: 165,
                        height: 165,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/wheat.png",
                                width: 50,
                                height: 50,
                              ),
                              const Text("Sell Crops"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        // await locationData.getCurrentPosition();

                        // await databaseref
                        //     .child("Active Users")
                        //     .child("List")
                        //     .child('4455667')
                        //     .set({
                        //   "lat": 19.228825,
                        //   "long": 72.854118,
                        //   "userId": "4455667"
                        // });
                        Navigator.push(
                          context,
                          PageTransition(
                            child: const CropHistory(),
                            type: PageTransitionType.fade,
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 248, 247, 247),
                            borderRadius: BorderRadius.circular(20)),
                        width: 165,
                        height: 165,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/history.png",
                                width: 45,
                                height: 45,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              const Text("History"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        await locationData.getCurrentPosition();
                        if (locationData.permissionAllowed == true) {
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            PageTransition(
                              child: const GoogleMaps(),
                              type: PageTransitionType.fade,
                            ),
                          );
                          // setState(() {
                          //   pressed = true;
                          // });
                        } else {
                          print("Permission Denied");
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 248, 247, 247),
                            borderRadius: BorderRadius.circular(20)),
                        width: 165,
                        height: 165,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/market.png",
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              const Text("NearBy Market"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        await locationData.getCurrentPosition();
                        if (locationData.permissionAllowed == true) {
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            PageTransition(
                              child: const CropEducation(),
                              type: PageTransitionType.fade,
                            ),
                          );
                          // setState(() {
                          //   pressed = true;
                          // });
                        } else {
                          print("Permission Denied");
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 248, 247, 247),
                            borderRadius: BorderRadius.circular(20)),
                        width: 165,
                        height: 165,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/homework.png",
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              const Text("Education"),
                            ],
                          ),
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

      // bottomNavigationBar: BottomAppBar(
      //   color: Colors.white,
      //   child: Container(
      //     height: 50,
      //     child: Row(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       children: [
      //         Container(
      //           child: Column(
      //             children: [
      //               Image.asset('assets/Layer 2.png'),
      //               Text(
      //                 'Home',
      //                 style: TextStyle(
      //                   color: Color(0xff3dab85),
      //                   fontSize: 12,
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //         Container(
      //           child: Column(
      //             children: [
      //               Image.asset('assets/trash 1.png'),
      //               Text(
      //                 'Cooking Food',
      //                 style: TextStyle(
      //                   color: Colors.grey,
      //                   fontSize: 12,
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //         CircleAvatar(
      //           child: Icon(Icons.search),
      //           backgroundColor: Color(0xff3dab85),
      //         ),
      //         Container(
      //           child: Column(
      //             children: [
      //               Image.asset('assets/heart.png'),
      //               Text(
      //                 'Favourites',
      //                 style: TextStyle(
      //                   color: Colors.grey,
      //                   fontSize: 12,
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //         Container(
      //           child: Column(
      //             children: [
      //               Image.asset('assets/cart.png'),
      //               Text(
      //                 'Cart',
      //                 style: TextStyle(
      //                   color: Colors.grey,
      //                   fontSize: 12,
      //                 ),
      //               )
      //             ],
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
