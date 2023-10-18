import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:test_map/data/model/place_details_model/location.dart';
import 'package:test_map/data/repository/place_repo.dart';
import 'package:test_map/helper/location_helper.dart';
import 'package:uuid/uuid.dart';

part 'map_state.dart';

final mapProvider = StateNotifierProvider<MapProvider, MapState>((ref) {
  final repo = ref.read(placeRepoProvider);
  return MapProvider(repo);
});

class MapProvider extends StateNotifier<MapState> {
  MapProvider(this.repo) : super(MapInitial());

  final PlaceRepo repo;
  final Completer<GoogleMapController> mapController = Completer();

  FloatingSearchBarController controller = FloatingSearchBarController();
  Set<Marker> markers = {};
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

  Future<void> goToMySearchedLocation(Location location) async {
    GoogleMapController controller = await mapController.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 20,
          target: LatLng(
            location.lat!,
            location.lng!,
          ),
        ),
      ),
    );
  }

  //! PlaceDetails
  Future<void> getPlaceDetails(String placeId) async {
    state = GetPlaceDetailsLoading();
    try {
      final sessiontoken = const Uuid().v4();
      final place = await repo.getPlacesDetails(
          placeId: placeId, sessiontoken: sessiontoken);
      final location = place.geometry!.location!;
      state = GetPlaceDetailsSuccess(location: location);
    } catch (e) {
      state = GetPlaceDetailsError(e.toString());
    }
    //
  }

  void buildSearchedPlaceMarker(Location location) {
    final marker = Marker(
      markerId: const MarkerId("1"),
      onTap: () async {
        await buildCurrentLocationMarker();
      },
      position: LatLng(location.lat!, location.lng!),
      infoWindow: const InfoWindow(title: "Searched Location"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );
    addMarker(marker);
  }

  Future<void> buildCurrentLocationMarker() async {
    final location = await LocationHelper.getCurrentLocation();
    final marker = Marker(
      markerId: const MarkerId("2"),
      onTap: () {},
      position: LatLng(location.altitude, location.longitude),
      infoWindow: const InfoWindow(title: "Searched Location"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );
    addMarker(marker);
  }

  void addMarker(Marker marker) {
    markers.add(marker);
    state = AddMarker();
  }
}
