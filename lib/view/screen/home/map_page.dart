import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:test_map/helper/location_helper.dart';
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

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      // margins: const EdgeInsets.only(top: 50),
      controller: controller,
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: const Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [],
            ),
          ),
        );
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
          buildFloatingSearchBar()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: moveToMyCurrentPosition,
        child: const Icon(Icons.place),
      ),
    );
  }
}
