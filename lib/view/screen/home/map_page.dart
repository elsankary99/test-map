import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:test_map/helper/location_helper.dart';
import 'package:test_map/view/widget/home_widget/floating_searchbar_widget.dart';
import 'package:test_map/view/widget/home_widget/my_drawer.dart';

@RoutePage()
class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static Position? position;
  static final CameraPosition _cameraPosition = CameraPosition(
      target: LatLng(position!.latitude, position!.longitude),
      zoom: 17,
      bearing: 0,
      tilt: 0);
  static final Completer<GoogleMapController> _mapController = Completer();
  FloatingSearchBarController controller = FloatingSearchBarController();
  Future<void> getMyCurrentLocation() async {
    position = await LocationHelper.getCurrentLocation().whenComplete(() {
      setState(() {});
    });
  }

  Future<void> moveToMyCurrentPosition() async {
    GoogleMapController controller = await _mapController.future;
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
  }

  Widget buildMap() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _cameraPosition,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      onMapCreated: (GoogleMapController controller) {
        _mapController.complete(controller);
      },
    );
  }

  @override
  void initState() {
    getMyCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          position != null
              ? buildMap()
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          const FloatingSearchBarWidget()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: moveToMyCurrentPosition,
        child: const Icon(Icons.place),
      ),
    );
  }
}
