import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nooow/provider/ui_provider.dart';
import 'package:nooow/ui/screens/near_by/components/places.dart';
import 'package:nooow/utils/app_colors.dart';
import 'package:nooow/utils/app_routes.dart';
import 'package:provider/provider.dart';

class NearByScreen extends StatefulWidget {
  const NearByScreen({super.key});

  @override
  State<NearByScreen> createState() => _NearByScreenState();
}

class _NearByScreenState extends State<NearByScreen> {
  double _currentLat = 0.0;
  double _currentLong = 0.0;
  CameraPosition _cameraPosition =
      const CameraPosition(target: LatLng(0, 0), zoom: 2);
  GoogleMapController? mapController;
  late ClusterManager _manager;
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = {};
  Future<Marker> Function(Cluster<Place>) get _markerBuilder =>
      (cluster) async {
        return Marker(
            markerId: MarkerId(cluster.getId()),
            position: cluster.location,
            onTap: () {
              log('---- $cluster');
              for (Place p in cluster.items) {
                log(p.toString());
              }
            },
            icon:
                // BitmapDescriptor.defaultMarkerWithHue(
                //     BitmapDescriptor.hueMagenta),
                await _getMarkerBitmap(cluster.isMultiple ? 125 : 75,
                    text: cluster.isMultiple ? cluster.count.toString() : null),
            infoWindow: InfoWindow(
              title: cluster.items.toString(),
            ));
      };

  Future<BitmapDescriptor> _getMarkerBitmap(int size, {String? text}) async {
    if (kIsWeb) size = (size / 2).floor();

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = Colors.red;
    final Paint paint2 = Paint()..color = Colors.white;

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);

    if (text != null) {
      TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: TextStyle(
            fontSize: size / 3,
            color: Colors.white,
            fontWeight: FontWeight.normal),
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
      );
    }

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png) as ByteData;

    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }

  //  function to get currentlocation using Geolocator
  _myPosition() async {
    // return Geolocator.requestPermission().then((value) =>
    //     Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high));
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  _getCurrentLatLong() async {
    var position = await _myPosition();
    setState(() {
      _currentLat = position.latitude;
      _currentLong = position.longitude;
// Cameraposion set on currentLat and CurrentLong
      _cameraPosition =
          CameraPosition(target: LatLng(_currentLat, _currentLong), zoom: 7);
    });
  }

  List<Place> items = [
    for (int i = 0; i < 100; i++)
      Place(
          name: 'Theater $i',
          latLng: LatLng(28.6074 + i * 0.001, 77.2363 + i * 0.001)),
    for (int i = 0; i < 100; i++)
      Place(
          name: 'Restaurant $i',
          // isClosed: i % 2 == 0,
          latLng: LatLng(31.9365 + i * 0.001, 77.5430 + i * 0.001)),
    for (int i = 0; i < 100; i++)
      Place(
          name: 'Bar $i',
          latLng: LatLng(29.2057 + i * 0.001, 74.7934 + i * 0.001)),
    for (int i = 0; i < 100; i++)
      Place(
          name: 'Hotel $i',
          latLng: LatLng(29.6871 + i * 0.001, 76.7645 + i * 0.001)),
    for (int i = 0; i < 100; i++)
      Place(
          name: 'Mall $i',
          latLng: LatLng(30.7834 + i * 0.001, 78.3463 + i * 0.001)),
    for (int i = 0; i < 100; i++)
      Place(
          name: 'Theka $i',
          latLng: LatLng(29.3032 + i * 0.001, 79.5692 + i * 0.001)),
  ];

  ClusterManager _initClusterManager() {
    return ClusterManager<Place>(items, _updateMarkers,
        markerBuilder: _markerBuilder);
  }

  void _updateMarkers(Set<Marker> markers) {
    log('Updated ${markers.length} markers');
    setState(() {
      this.markers = markers;
    });
  }

  @override
  void initState() {
    _manager = _initClusterManager();
    // _getCurrentLatLong();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
        elevation: 0.0,
        title: Text(
          'Nearby',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
            color: AppColors.white,
          ),
        ),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1),
                child: IconButton(
                  onPressed: () {
                    log('Favourites Pressed');
                    Navigator.pushNamed(context, AppRoutes.myListScreen);
                  },
                  icon: const Icon(
                    Icons.favorite_border_outlined,
                    color: AppColors.white,
                    size: 21,
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 2,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.red,
                  child: Center(
                    child: Text(
                      '0',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 9,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              log('Search Pressed');
            },
            icon: const Icon(Icons.search, size: 21),
          ),
          Stack(
            alignment: Alignment.topRight,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1),
                child: IconButton(
                  onPressed: () {
                    log('Notifications Pressed');
                  },
                  icon: const Icon(
                    Icons.notifications_none,
                    size: 21,
                    color: AppColors.white,
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 2,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.red,
                  child: Center(
                    child: Text(
                      '0',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 9,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Consumer<UIProvider>(builder: (context, uiProvider, child) {
        return Stack(
          children: [
            ListView(
              primary: false,
              padding: const EdgeInsets.only(
                  top: 18, bottom: 30, left: 21, right: 19),
              children: [
                Container(
                  height: size.height * 0.60,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // child: GoogleMap(
                  //   myLocationEnabled: true,
                  //   mapType: MapType.normal,
                  //   initialCameraPosition: _cameraPosition,
                  //   markers: markers,
                  //   onMapCreated: (GoogleMapController controller) {
                  //     setState(() {
                  //       mapController = controller;
                  //       _controller.complete(controller);
                  //       _manager.setMapId(controller.mapId);
                  //     });
                  //     mapController?.animateCamera(
                  //       CameraUpdate.newCameraPosition(
                  //         CameraPosition(
                  //           target: LatLng(_currentLat, _currentLong),
                  //           zoom: 7,
                  //         ),
                  //       ),
                  //     );
                  //   },
                  //   onCameraMove: _manager.onCameraMove,
                  //   onCameraIdle: _manager.updateMap,
                  // ),
                ),
                const SizedBox(height: 18),
                Text(
                  "Selected Location",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Bhangel, Greater Noida, 201306",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            uiProvider.loading
                ? Container(
                    height: size.height,
                    color: AppColors.whiteBackground.withOpacity(0.4),
                    child: const Center(
                      child:
                          CircularProgressIndicator(color: AppColors.navyBlue),
                    ),
                  )
                : const SizedBox()
          ],
        );
      }),
    );
  }
}
