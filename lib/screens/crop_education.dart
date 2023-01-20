import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:video_player/video_player.dart';
// import 'package:video_player/video_player.dart';

class CropEducation extends StatefulWidget {
  const CropEducation({super.key});

  @override
  State<CropEducation> createState() => _CropEducationState();
}

class _CropEducationState extends State<CropEducation> {
  late VideoPlayerController _controller;
  late Future<void> hi;
  @override
  void initState() {
    // TODO: implement initState
    _controller = VideoPlayerController.network(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4");
    hi = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(1.0);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView(
          children: <Widget>[
            CarouselSlider(
              items: [
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                          image: AssetImage("assets/crop2.jpg"),
                          opacity: 0.4,
                          fit: BoxFit.cover)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Text(
                        'तुम हो तो हम हैं',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          'Never let anyone sleep hungry',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                          image: AssetImage("assets/crop3.jpg"),
                          fit: BoxFit.cover,
                          opacity: 0.4)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          '"ये कृषि प्रधान देश है, यहाँ के मालिक किसान है।"',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      Text(
                        'You are the real ogs',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                          image: AssetImage("assets/crop4.jpg"),
                          fit: BoxFit.cover,
                          opacity: 0.4)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Text(
                        'मुझे किसान में ईश्वर नजर आते है।',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          'Never let anyone sleep hungry',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                )
              ],
              options: CarouselOptions(
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Points To Remember while sowing seeds:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                          "प्रत्येक बीज के अंदर एक छोटा पौधा होता है जो विकसित होने के\nलिए सही परिस्थितियों की प्रतीक्षा कर रहा होता है।"),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("बीजों को उचित गहराई पर उगाना चाहिए"),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("उन्हें एक दूसरे से उचित दूरी पर बोना चाहिए।"),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                          "बुवाई के लिए उपयोग किए जाने वाले बीज साफ, स्वस्थ और किसी\nभीबीमारी या संक्रमण से मुक्त होने चाहिए।"),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("बुवाई के समय तापमान बहुत महत्वपूर्ण होता है"),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Reach Out To Us At:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text("Email At: kisaanseva@gmail.com"),
                  Text("Call At: 9004137508"),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Video Tutorial To Use This Application:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          _controller.play();
                        }
                      });
                    },
                    child: Container(
                        width: 500,
                        height: 280,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 189, 247, 191)
                                .withOpacity(0.8),
                            borderRadius: BorderRadius.circular(15)),
                        child: FutureBuilder(
                          future: hi,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: VideoPlayer(_controller),
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
