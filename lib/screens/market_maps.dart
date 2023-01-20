import 'dart:typed_data';
import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kisaankahaak/screens/svg_creator.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:ui' as ui;
import 'package:provider/provider.dart';

import '../data/google_maps_data.dart';
import '../providers/location_provider.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({super.key});
  static const String id = 'map-screen';

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  final databaseref = FirebaseDatabase.instance.ref();

  int pending = 0;

  Map optionsmap = {"date": DateTime.now().toString().split(" ")[0]};
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  late LatLng currentLocation;
  late GoogleMapController _mapController;
  // Set<Marker> markers = {};
  List<UserMaps> list = [];
  List<UserMaps> lis2 = [];
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void initMarker(UserMaps specify, specifyId) async {
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(specify.lat, specify.long),
        icon: await bitmapDescriptorFromSvgAsset(context, "Market Place"),
        infoWindow: InfoWindow(
          title: '${specify.status}',
          snippet: specify.pending,
          onTap: () {},
        ));
    setState(() {
      markers[markerId] = marker;
    });
  }

  getUsers() async {
    final snapshot =
        await FirebaseDatabase.instance.ref('Active Users/List').get();

    final map = snapshot.value as Map<dynamic, dynamic>;

    map.forEach((key, value) {
      final user = UserMaps.fromMap(value);

      list.add(user);
    });
    for (int i = 0; i < list.length; i++) {
      initMarker(list[i], list[i].userId);
    }
    setState(() {});
    print(list);

    // setState(() {
    //   list2 = list;
    // });
  }

  // getTaskNumber(UserDetails userdetails, LoginData loginDataProvider) async {
  //   FutureBuilder<Map>(
  //     future: TaskListService().getTaskType(userDetails, optionsmap),
  //     builder: (context, snapshot) {
  //       switch (snapshot.connectionState) {
  //         case ConnectionState.none:
  //           return Text("no");
  //         case ConnectionState.waiting:
  //           return Text(
  //             "1",
  //             style: kTextStyle,
  //           );
  //         case ConnectionState.active:
  //           return Text("1", style: kTextStyle);
  //         case ConnectionState.done:
  //           if (!snapshot.hasData) {
  //             print("yesssssss");
  //             return Text("1", style: kTextStyle);
  //           } else {
  //             var sellersFilter;
  //             if (snapshot.data!["taskTypes"] != null) {
  //               sellersFilter = snapshot.data!["taskTypes"];
  //               print("prinin");
  //               print(sellersFilter);
  //             } else {
  //               sellersFilter = [];
  //             }
  //             return Text("${sellersFilter[0]['totalResult']}",
  //                 style: kTextStyle);
  //           }
  //       }
  //     },
  //   );
  // }

  @override
  void initState() {
    // TODO: implement initState
    // userDetails = Provider.of<UserDetails>(context, listen: false);
    // LoginData loginDataProvider =
    //     Provider.of<LoginData>(context, listen: false);

    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // LoginData loginDataProvider = Provider.of<LoginData>(context);
    final locationData = Provider.of<LocationProvider>(context);

    setState(() {
      currentLocation = LatLng(locationData.latitude, locationData.longitude);
    });

    void onCreated(GoogleMapController controller) {
      setState(() {
        _mapController = controller;
      });
    }

    // Set<Marker> getMarker() {
    //   return <Marker>[
    //     Marker(
    //         markerId: MarkerId('Grocery Store'),
    //         position: LatLng(locationData.latitude, locationData.longitude),
    //         icon: BitmapDescriptor.defaultMarker,
    //         infoWindow: InfoWindow(title: 'Shops'))
    //   ].toSet();
    // }

    // const CameraPosition initialcameraposition =
    //     CameraPosition(target: LatLng(26.5123, 80.2329), zoom: 14);

    return Scaffold(
        body: SafeArea(
      child: Stack(children: [
        GoogleMap(
          initialCameraPosition:
              CameraPosition(target: currentLocation, zoom: 14),
          zoomControlsEnabled: false,
          minMaxZoomPreference: MinMaxZoomPreference(1.5, 20.8),
          myLocationEnabled: true,
          markers: Set<Marker>.of(
            markers.values,
          ),

          myLocationButtonEnabled: true,
          mapType: MapType.normal,
          mapToolbarEnabled: true,

          onCameraMove: (CameraPosition position) {
            locationData.onCameraMove(position);
          },
          onMapCreated: onCreated,
          // onCameraIdle: () {
          //   locationData.getMoveCamera();
          // },
        ),
      ]),
    ));
  }
}
