// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nooow/provider/api_services_provider.dart';
import 'package:nooow/provider/ui_provider.dart';
import 'package:nooow/services/local_db.dart';
import 'package:nooow/ui/components/drawer.dart';
import 'package:nooow/ui/components/user_not_found_error.dart';
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
  bool? isUserSignedIn = false;
  bool signedIn = false;
  Placemark? currentAddress;
  late UIProvider _uiProvider;

  final CameraPosition _cameraPosition =
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
            icon: await _getMarkerBitmap(cluster.isMultiple ? 125 : 75,
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
          fontWeight: FontWeight.normal,
        ),
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<UIProvider>(context, listen: false).loaderTrue();

      if (ApiServiceProvider().currentPosition == null) {
        await ApiServiceProvider().getCurrentPosition(context);
      } else {
        List<Placemark>? address = await placemarkFromCoordinates(
            ApiServiceProvider().currentPosition!.latitude,
            ApiServiceProvider().currentPosition!.longitude,
            localeIdentifier: 'en');
        await ApiServiceProvider().vendorData(context);

        if (address.isEmpty) {
        } else {
          currentAddress = address[0];
        }
      }
      Provider.of<UIProvider>(context, listen: false).loaderFalse();
    });

    super.initState();
  }

  bool get isSignIn => (AppSharedPrefrence().userData == null ||
          AppSharedPrefrence().userData!.isEmpty)
      ? false
      : true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    log('Address is\n${ApiServiceProvider().currentPosition}');
    return Scaffold(
      drawer: AppDrawer(
        isUserSignedIn: isSignIn,
        backgroundHeight: size.height * 0.18,
      ),
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
          // Favorites
          InkWell(
            onTap: () {
              !isSignIn
                  ? Navigator.pushNamed(context, AppRoutes.signInScreen)
                  : Navigator.pushNamed(context, AppRoutes.myListScreen);
            },
            child: SizedBox(
              width: 26,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 17, right: 6),
                    child: Icon(
                      Icons.favorite_border_outlined,
                      color: AppColors.white,
                      size: 22,
                    ),
                  ),
                  Positioned(
                    top: 12,
                    // right: 2,
                    left: 12,
                    child: CircleAvatar(
                      radius: 7,
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
            ),
          ),
          // Notifications
          InkWell(
            onTap: () {
              !isSignIn
                  ? Navigator.pushNamed(context, AppRoutes.signInScreen)
                  : log('Notifications');
            },
            child: SizedBox(
              width: 26,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 17, right: 6),
                    child: Icon(
                      Icons.notifications_none,
                      color: AppColors.white,
                      size: 22,
                    ),
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: CircleAvatar(
                      radius: 7,
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
            ),
          ),
          const SizedBox(width: 2)
        ],
      ),
      body: Consumer<UIProvider>(builder: (context, uiProvider, child) {
        return (isSignIn == false)
            ? const UserNotFoundErrorWidget()
            : SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 18, bottom: 30, left: 21, right: 19),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: size.height * 0.60,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: GoogleMap(
                              myLocationEnabled: true,
                              myLocationButtonEnabled: true,
                              mapType: MapType.normal,
                              initialCameraPosition: _cameraPosition,
                              markers: markers,
                              onMapCreated: (GoogleMapController controller) {
                                setState(() {
                                  mapController = controller;
                                  _controller.complete(controller);
                                  _manager.setMapId(controller.mapId);
                                });
                                mapController?.animateCamera(
                                  CameraUpdate.newCameraPosition(
                                    CameraPosition(
                                      target: LatLng(
                                          ApiServiceProvider()
                                                  .currentPosition
                                                  ?.latitude ??
                                              0,
                                          ApiServiceProvider()
                                                  .currentPosition
                                                  ?.longitude ??
                                              0),
                                      zoom: 7,
                                    ),
                                  ),
                                );
                              },
                              onCameraMove: _manager.onCameraMove,
                              onCameraIdle: _manager.updateMap,
                            ),
                          ),
                          const SizedBox(height: 18),
                          Text(
                            "Current Location",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: AppColors.black,
                            ),
                          ),
                          const SizedBox(height: 5),
                          currentAddress == null
                              ? const SizedBox.shrink()
                              : Text(
                                  "${currentAddress?.street}, ${currentAddress?.administrativeArea}, ${currentAddress?.subLocality}, ${currentAddress?.country}, ${currentAddress?.postalCode}",
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: AppColors.black,
                                  ),
                                ),
                        ],
                      ),
                    ),
                    uiProvider.loading
                        ? Container(
                            height: size.height,
                            color: AppColors.whiteBackground.withOpacity(0.4),
                            child: const Center(
                              child: CircularProgressIndicator(
                                  color: AppColors.navyBlue),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              );
      }),
    );
  }
}
