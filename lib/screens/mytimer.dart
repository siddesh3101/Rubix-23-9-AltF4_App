import 'dart:async';
import 'package:flutter/material.dart';

int secondsLeft = 500;

class CountDownTimer extends StatefulWidget {
  const CountDownTimer({Key? key}) : super(key: key);

  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  late Timer countDown;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countDown = Timer.periodic(Duration(seconds: 1), (timer) {
      secondsLeft--;
      if (secondsLeft <= 0) {
        timer.cancel();
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text("$secondsLeft seconds left");
  }
}
