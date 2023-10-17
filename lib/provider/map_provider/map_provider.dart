import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:test_map/helper/location_helper.dart';

part 'map_state.dart';

final mapProvider =
    StateNotifierProvider<MapProvider, MapState>((ref) => MapProvider());

class MapProvider extends StateNotifier<MapState> {
  MapProvider() : super(MapInitial());
  final Completer<GoogleMapController> mapController = Completer();
  FloatingSearchBarController controller = FloatingSearchBarController();

  Future<void> moveToMyCurrentPosition() async {
    final position = await LocationHelper.getCurrentLocation();
    GoogleMapController controller = await mapController.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 20,
          target: LatLng(
            position.latitude,
            position.longitude,
          ),
        ),
      ),
    );
  }
}
