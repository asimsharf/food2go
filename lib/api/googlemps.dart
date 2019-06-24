//import 'dart:async';
//
//import 'package:flutter/material.dart';
//
//class GoogleMaps extends StatefulWidget {
//  @override
//  _GoogleMapsState createState() => _GoogleMapsState();
//}
//
//class _GoogleMapsState extends State<GoogleMaps> {
//  Completer<GoogleMapController> _controller = Completer();
//  @override
//  void initState() {
//    super.initState();
//  }
//
//  double zoomVal = 5.0;
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        leading: IconButton(
//          icon: Icon(Icons.arrow_left),
//          onPressed: () {},
//        ),
//        title: Text("New Yourk"),
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.search),
//            onPressed: () {},
//          )
//        ],
//      ),
//      body: Stack(
//        children: <Widget>[
//          (context),
////          _zoomminusfunction(),
////          _zoomplusfunction(),
////          _buildController(),
//        ],
//      ),
//    );
//  }
//
//  Widget _googlemap(BuildContext context){
//  	return Container(
//		  height: MediaQuery.of(context).size.height,
//		  width: MediaQuery.of(context).size.width,
//		  child: GoogleMap(
//			  mapType: MapType.normal,
//			  initialCameraPosition: CameraPosition(target: LatLang)
//		  ),
//	  );
//  }
//
//}
//
