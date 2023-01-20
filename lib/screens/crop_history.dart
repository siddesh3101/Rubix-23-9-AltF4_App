import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:kisaankahaak/screens/mytimer.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
// import 'package:slide_countdown_clock/slide_countdown_clock.dart';

class CropHistory extends StatefulWidget {
  const CropHistory({super.key});

  @override
  State<CropHistory> createState() => _CropHistoryState();
}

final user = FirebaseAuth.instance.currentUser;

class _CropHistoryState extends State<CropHistory> {
  // var user1 = user!.uid;

  final ref = FirebaseDatabase.instance.ref('Sold Crops/${user!.uid}');
  final dataref = FirebaseDatabase.instance.ref('Crops');
  DatabaseReference db = FirebaseDatabase.instance.ref('Sold Crops');
  CountDownController _controller = CountDownController();
  bool _isPause = false;
  Timer? countdownTimer;
  final _pricecontroller = TextEditingController();
  Duration myDuration = Duration(seconds: 30);

  var setDialog;
  @override
  void initState() {
    // TODO: implement initState
    // print(user!.displayName);
    print(user!.uid);

    super.initState();
  }

  // void startTimer() {
  //   countdownTimer =
  //       Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  // }

  void setCountDown(String id) {
    final reduceSecondsBy = 1;
    setDialog(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      print(id);
      if (seconds < 0) {
        countdownTimer!.cancel();
        dataref.child(id).remove();
        Navigator.of(context).pop();

        print("domne");
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 0,
          title: const Text("Sold Crops"),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              child: FirebaseAnimatedList(
            query: ref,
            defaultChild: Center(child: CircularProgressIndicator()),
            itemBuilder: (context, snapshot, animation, index) {
              var myInt = int.parse(snapshot.child('max_bid').value.toString());
              assert(myInt is int);
              var sv = myInt - (0.05 * myInt); // 123
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 2, // soften the shadow
                        spreadRadius: 3, //extend the shadow
                        offset: const Offset(
                          3, // Move to right 5  horizontally
                          3, // Move to bottom 5 Vertically
                        ),
                      )
                    ],
                  ),
                  child: Row(children: [
                    const SizedBox(
                      width: 5,
                    ),
                    Image.network(
                      snapshot.child('title').value.toString(),
                      width: 70,
                      height: 70,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Base Price - ₹${snapshot.child('price').value}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            snapshot.child('desc').value.toString(),
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.5)),
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 15, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Price Lock - ${sv}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "By - ${snapshot.child('max_bid_by').value.toString()}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              );
              // return ListTile(
              //   title: Text("₹" + snapshot.child('price').value.toString()),
              //   leading:
              //       Image.network(snapshot.child('title').value.toString()),
              //   subtitle: Text(snapshot.child('desc').value.toString()),
              //   tileColor: Color.fromARGB(255, 239, 255, 239),
              // );
            },
          ))
        ]),
      ),
    );
  }
}
