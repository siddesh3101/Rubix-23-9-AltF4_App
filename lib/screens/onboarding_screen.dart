import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:kisaankahaak/constants/constants.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _controller = PageController(initialPage: 0);
  int _currentpage = 0;

  final List<Widget> _pages = [
    Column(
      children: [
        Expanded(child: Image.asset("assets/kisaan.png")),
        const Text(
          "Order Online From Your Favourite Store",
          textAlign: TextAlign.center,
          style: kPageViewTextStyle,
        ),
      ],
    ),
    Column(
      children: [
        Expanded(
            child: Image.asset(
          "assets/kisaan.png",
        )),
        const Text("Enter Your Address", style: kPageViewTextStyle),
      ],
    ),
    Column(
      children: [
        Expanded(child: Image.asset("assets/kisaan.png")),
        const Text("Get Food Delivered", style: kPageViewTextStyle),
      ],
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: PageView(
          controller: _controller,
          children: _pages,
          onPageChanged: (value) {
            setState(() {
              _currentpage = value;
            });
          },
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      DotsIndicator(
        dotsCount: _pages.length,
        position: _currentpage.toDouble(),
        decorator: DotsDecorator(
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            activeColor: Colors.deepOrangeAccent),
      ),
      const SizedBox(
        height: 20,
      ),
    ]);
  }
}
