import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:kisaankahaak/screens/mytimer.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
// import 'package:slide_countdown_clock/slide_countdown_clock.dart';

class BuyCrops extends StatefulWidget {
  const BuyCrops({super.key});

  @override
  State<BuyCrops> createState() => _BuyCropsState();
}

class _BuyCropsState extends State<BuyCrops> {
  final ref = FirebaseDatabase.instance.ref('Crops').orderByChild('price');
  final dataref = FirebaseDatabase.instance.ref('Crops');
  DatabaseReference db = FirebaseDatabase.instance.ref('Sold Crops');
  final CollectionReference profileList =
      FirebaseFirestore.instance.collection('users');
  CountDownController _controller = CountDownController();
  bool _isPause = false;
  late String name;
  Timer? countdownTimer;
  final _pricecontroller = TextEditingController();
  Duration myDuration = Duration(seconds: 30);
  final user = FirebaseAuth.instance.currentUser;
  var setDialog;
  @override
  void initState() {
    // TODO: implement initState

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

  void _farmername() async {
    final docUser = profileList.doc(user!.uid);
    final snapshot = await docUser.get();
    var data = snapshot.data() as Map;
    // var _list = data.values.toList();
    setState(() {
      name = data["name"];
    });
  }

  @override
  Widget build(BuildContext context) {
    _farmername();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 0,
          title: const Text("Buy Crops"),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              child: FirebaseAnimatedList(
            query: ref,
            itemBuilder: (context, snapshot, animation, index) {
              if (index == 0) {
                // DateTime dt1 = DateTime.now();
                // DateTime dt2 = DateTime.parse(
                //     "${snapshot.child('date').value.toString()}");

                // Duration diff = dt2.difference(dt1);

                // String id = DateTime.now().microsecondsSinceEpoch.toString();
                // if (diff.isNegative) {
                //   dataref.child(snapshot.child('id').value.toString()).remove();
                //   db
                //       .child(snapshot.child('farmer_id').value.toString())
                //       .child(id)
                //       .set({
                //     'id': id,
                //     'title': snapshot.child('title').value.toString(),
                //     'price': snapshot.child('price').value.toString(),
                //     'desc': snapshot.child('desc').value.toString(),
                //     'date': snapshot.child('date').value.toString(),
                //     'max_bid': snapshot.child('max_bid').value.toString()
                //   });
                // }
                return InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setDialogState) {
                            String strDigits(int n) =>
                                n.toString().padLeft(2, '0');
                            final days = strDigits(myDuration.inDays);

                            // Step 7
                            final hours =
                                strDigits(myDuration.inHours.remainder(24));
                            final minutes =
                                strDigits(myDuration.inMinutes.remainder(60));
                            final seconds =
                                strDigits(myDuration.inSeconds.remainder(60));
                            setDialog = setDialogState;
                            DateTime dt1 = DateTime.now();
                            DateTime dt2 = DateTime.parse(
                                "${snapshot.child('date').value.toString()}");

                            Duration diff = dt2.difference(dt1);
                            // countdownTimer = Timer.periodic(
                            //     Duration(seconds: 1),
                            //     (_) => setCountDown(
                            //         snapshot.child('id').value.toString()));
                            // setDialogState(() {});

                            return Dialog(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: SizedBox(
                                  height: 600,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Image.network(
                                              snapshot
                                                  .child('title')
                                                  .value
                                                  .toString(),
                                              width: 70,
                                              height: 70,
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Base Price - ₹${snapshot.child('price').value}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  snapshot
                                                      .child('desc')
                                                      .value
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.5)),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Recent Bid",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        snapshot
                                                    .child('max_bid')
                                                    .value
                                                    .toString() ==
                                                snapshot
                                                    .child('price')
                                                    .value
                                                    .toString()
                                            ? const Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "No one has bid yet",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ))
                                            : Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  snapshot
                                                      .child('max_bid')
                                                      .value
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                        const SizedBox(
                                          height: 30,
                                        ),

                                        const Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Bid Ends In",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        // Align(
                                        //   alignment: Alignment.center,
                                        //   child: InkWell(
                                        //     onTap: () {
                                        //       countdownTimer = Timer.periodic(
                                        //           Duration(seconds: 1),
                                        //           (_) => setCountDown(snapshot
                                        //               .child('id')
                                        //               .value
                                        //               .toString()));
                                        //       setDialogState(() {});
                                        //     },
                                        //     child: Text(
                                        //       '$days:$hours:$minutes:$seconds',
                                        //       style: const TextStyle(
                                        //           fontWeight: FontWeight.bold,
                                        //           color: Colors.black,
                                        //           fontSize: 50),
                                        //     ),
                                        //   ),
                                        // ),
                                        const SizedBox(
                                          height: 15,
                                        ),

                                        // CountDownTimer()
                                        diff.isNegative
                                            ? Text("Sold")
                                            :
                                            // Alert(
                                            //         context: context,
                                            //         title: 'Done',
                                            //         style: AlertStyle(
                                            //           isCloseButton: true,
                                            //           isButtonVisible: false,
                                            //           titleStyle: TextStyle(
                                            //             color: Colors.black,
                                            //             fontSize: 30.0,
                                            //           ),
                                            //         ),
                                            //         type: AlertType.success)
                                            //     .show();:
                                            Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: CircularCountDownTimer(
                                                    width: 300,
                                                    height: 300,
                                                    duration: diff.inSeconds,
                                                    fillColor: Colors.amber,
                                                    color: Colors.white,
                                                    controller: _controller,
                                                    backgroundColor:
                                                        Colors.white54,
                                                    strokeWidth: 10.0,
                                                    // autoStart: true,
                                                    strokeCap: StrokeCap.round,
                                                    isTimerTextShown: true,
                                                    isReverse: true,
                                                    onComplete: () {
                                                      dataref
                                                          .child(snapshot
                                                              .child('id')
                                                              .value
                                                              .toString())
                                                          .remove();
                                                      String id = DateTime.now()
                                                          .microsecondsSinceEpoch
                                                          .toString();

                                                      db
                                                          .child(snapshot
                                                              .child(
                                                                  'farmer_id')
                                                              .value
                                                              .toString())
                                                          .child(id)
                                                          .set({
                                                        'id': id,
                                                        'title': snapshot
                                                            .child('title')
                                                            .value
                                                            .toString(),
                                                        'price': snapshot
                                                            .child('price')
                                                            .value
                                                            .toString(),
                                                        'desc': snapshot
                                                            .child('desc')
                                                            .value
                                                            .toString(),
                                                        'date': snapshot
                                                            .child('date')
                                                            .value
                                                            .toString(),
                                                        'max_bid': snapshot
                                                            .child('max_bid')
                                                            .value
                                                            .toString(),
                                                        'max_bid_by':
                                                            name.toString()
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                      // Alert(
                                                      //         context: context,
                                                      //         title: 'Done',
                                                      //         style: AlertStyle(
                                                      //           isCloseButton:
                                                      //               true,
                                                      //           isButtonVisible:
                                                      //               false,
                                                      //           titleStyle:
                                                      //               TextStyle(
                                                      //             color: Colors
                                                      //                 .black,
                                                      //             fontSize:
                                                      //                 30.0,
                                                      //           ),
                                                      //         ),
                                                      //         type: AlertType
                                                      //             .success)
                                                      //     .show();
                                                      // _controller.restart();
                                                    },
                                                    textStyle: const TextStyle(
                                                        fontSize: 50.0,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                        // SlideCountdownClock(
                                        //     duration:
                                        //         Duration(days: 24, minutes: 100))
                                        // ElevatedButton(
                                        //     onPressed: () {}, child: Text("Submit"))
                                      ]),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 139, 248, 143),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 2, // soften the shadow
                            spreadRadius: 3, //extend the shadow
                            offset: Offset(
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
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                snapshot.child('desc').value.toString(),
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.5)),
                              )
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 116, 91),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          height: 300,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextFormField(
                                                  controller: _pricecontroller,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration:
                                                      const InputDecoration(
                                                          labelText:
                                                              "New Bid Price"),
                                                ),
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                                // SlideCountdownClock(
                                                //     duration:
                                                //         Duration(days: 24, minutes: 100))
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        var myInt = int.parse(
                                                            '${_pricecontroller.text.trim()}');
                                                        assert(myInt is int);
                                                        print(myInt);
                                                        var baseprice = int.parse(
                                                            '${snapshot.child('price').value}');
                                                        assert(
                                                            baseprice is int);
                                                        var maxprice = int.parse(
                                                            '${snapshot.child('max_bid').value}');
                                                        assert(maxprice is int);

                                                        if (myInt < baseprice ||
                                                            myInt < maxprice) {
                                                          // Navigator.of(context)
                                                          //     .pop();
                                                          Alert(
                                                                  context:
                                                                      context,
                                                                  title:
                                                                      'Error',
                                                                  style:
                                                                      const AlertStyle(
                                                                    isCloseButton:
                                                                        true,
                                                                    isButtonVisible:
                                                                        false,
                                                                    titleStyle:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          30.0,
                                                                    ),
                                                                  ),
                                                                  type: AlertType
                                                                      .error)
                                                              .show();
                                                        } else {
                                                          dataref
                                                              .child(snapshot
                                                                  .child('id')
                                                                  .value
                                                                  .toString())
                                                              .update({
                                                            'max_bid':
                                                                _pricecontroller
                                                                    .text
                                                                    .trim()
                                                          });
                                                          Navigator.of(context)
                                                              .pop();
                                                        }
                                                      },
                                                      child:
                                                          const Text("Submit")),
                                                )
                                              ]),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Text("Start Bidding")),
                        )
                      ]),
                    ),
                  ),
                );
                // return ListTile(
                //   title: Text("₹" + snapshot.child('price').value.toString()),
                //   leading:
                //       Image.network(snapshot.child('title').value.toString()),
                //   subtitle: Text(snapshot.child('desc').value.toString()),
                //   tileColor: Color.fromARGB(255, 239, 255, 239),
                // );
              } else {
                DateTime biddingDateEnd = DateTime.parse(
                    '${snapshot.child('date').value.toString()}');
                DateTime dateTimeNow = DateTime.now();
                final differenceInDays =
                    biddingDateEnd.difference(dateTimeNow).inDays;
                myDuration = Duration(seconds: 10);

                // print('$differenceInDays');
                return InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setDialogState) {
                            String strDigits(int n) =>
                                n.toString().padLeft(2, '0');
                            final days = strDigits(myDuration.inDays);
                            DateTime dt1 = DateTime.now();
                            DateTime dt2 = DateTime.parse(
                                "${snapshot.child('date').value.toString()}");

                            Duration diff = dt2.difference(dt1);

                            // Step 7
                            final hours =
                                strDigits(myDuration.inHours.remainder(24));
                            final minutes =
                                strDigits(myDuration.inMinutes.remainder(60));
                            final seconds =
                                strDigits(myDuration.inSeconds.remainder(60));
                            setDialog = setDialogState;
                            return Dialog(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 600,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Image.network(
                                              snapshot
                                                  .child('title')
                                                  .value
                                                  .toString(),
                                              width: 70,
                                              height: 70,
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Base Price - ₹${snapshot.child('price').value}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  snapshot
                                                      .child('desc')
                                                      .value
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.5)),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Recent Bid",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        snapshot.child('max_bid') ==
                                                snapshot.child('price')
                                            ? const Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "No one has bid yet",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ))
                                            : Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "${snapshot.child('max_bid').value.toString()}",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                        const SizedBox(
                                          height: 30,
                                        ),

                                        const Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Bid Ends In",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        diff.isNegative
                                            ? Text("Sold")
                                            :
                                            // Alert(
                                            //         context: context,
                                            //         title: 'Done',
                                            //         style: AlertStyle(
                                            //           isCloseButton: true,
                                            //           isButtonVisible: false,
                                            //           titleStyle: TextStyle(
                                            //             color: Colors.black,
                                            //             fontSize: 30.0,
                                            //           ),
                                            //         ),
                                            //         type: AlertType.success)
                                            //     .show();:
                                            Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: CircularCountDownTimer(
                                                    width: 300,
                                                    height: 300,
                                                    duration: diff.inSeconds,
                                                    fillColor: Colors.amber,
                                                    color: Colors.white,
                                                    controller: _controller,
                                                    backgroundColor:
                                                        Colors.white54,
                                                    strokeWidth: 10.0,
                                                    // autoStart: true,
                                                    strokeCap: StrokeCap.round,
                                                    isTimerTextShown: true,
                                                    isReverse: true,
                                                    onComplete: () {
                                                      dataref
                                                          .child(snapshot
                                                              .child('id')
                                                              .value
                                                              .toString())
                                                          .remove();
                                                      String id = DateTime.now()
                                                          .microsecondsSinceEpoch
                                                          .toString();

                                                      db
                                                          .child(user!.uid)
                                                          .child(id)
                                                          .set({
                                                        'id': id,
                                                        'title': snapshot
                                                            .child('title')
                                                            .value
                                                            .toString(),
                                                        'price': snapshot
                                                            .child('price')
                                                            .value
                                                            .toString(),
                                                        'desc': snapshot
                                                            .child('desc')
                                                            .value
                                                            .toString(),
                                                        'date': snapshot
                                                            .child('date')
                                                            .value
                                                            .toString(),
                                                        'max_bid': snapshot
                                                            .child('max_bid')
                                                            .value
                                                            .toString()
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                      // Alert(
                                                      //         context: context,
                                                      //         title: 'Done',
                                                      //         style: AlertStyle(
                                                      //           isCloseButton:
                                                      //               true,
                                                      //           isButtonVisible:
                                                      //               false,
                                                      //           titleStyle:
                                                      //               TextStyle(
                                                      //             color: Colors
                                                      //                 .black,
                                                      //             fontSize:
                                                      //                 30.0,
                                                      //           ),
                                                      //         ),
                                                      //         type: AlertType
                                                      //             .success)
                                                      //     .show();
                                                      // _controller.restart();
                                                    },
                                                    textStyle: const TextStyle(
                                                        fontSize: 50.0,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                        // Align(
                                        //   alignment: Alignment.center,
                                        //   child: InkWell(
                                        //     onTap: () {
                                        //       countdownTimer = Timer.periodic(
                                        //           Duration(seconds: 1),
                                        //           (_) => setCountDown(snapshot
                                        //               .child('id')
                                        //               .value
                                        //               .toString()));
                                        //       setDialogState(() {});
                                        //     },
                                        //     child: Text(
                                        //       '$days:$hours:$minutes:$seconds',
                                        //       style: const TextStyle(
                                        //           fontWeight: FontWeight.bold,
                                        //           color: Colors.black,
                                        //           fontSize: 50),
                                        //     ),
                                        //   ),
                                        // ),
                                        // SlideCountdownClock(
                                        //     duration:
                                        //         Duration(days: 24, minutes: 100))
                                        // ElevatedButton(
                                        //     onPressed: () {}, child: Text("Submit"))
                                      ]),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  child: Padding(
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
                            offset: Offset(
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
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                snapshot.child('desc').value.toString(),
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.5)),
                              )
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 116, 91),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          height: 300,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextFormField(
                                                  controller: _pricecontroller,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration:
                                                      const InputDecoration(
                                                          labelText:
                                                              "New Bid Price"),
                                                ),
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                                // SlideCountdownClock(
                                                //     duration:
                                                //         Duration(days: 24, minutes: 100))
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        var myInt = int.parse(
                                                            '${_pricecontroller.text.trim()}');
                                                        assert(myInt is int);
                                                        print(myInt);
                                                        var baseprice = int.parse(
                                                            '${snapshot.child('price').value}');
                                                        assert(
                                                            baseprice is int);

                                                        if (myInt < baseprice) {
                                                          Navigator.of(context)
                                                              .pop();
                                                        } else {
                                                          dataref
                                                              .child(snapshot
                                                                  .child('id')
                                                                  .value
                                                                  .toString())
                                                              .update({
                                                            'max_bid':
                                                                _pricecontroller
                                                                    .text
                                                                    .trim()
                                                          });
                                                          Navigator.of(context)
                                                              .pop();
                                                        }
                                                      },
                                                      child:
                                                          const Text("Submit")),
                                                )
                                              ]),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Text("Start Bidding")),
                        )
                      ]),
                    ),
                  ),
                );
              }
            },
          ))
        ]),
      ),
    );
  }
}
