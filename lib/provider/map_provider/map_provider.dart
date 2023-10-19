import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:test_map/data/model/place_details_model/place_details_model.dart';
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

  //! PlaceDetails
  Future<void> getPlaceDetails(String placeId) async {
    state = GetPlaceDetailsLoading();
    try {
      final sessiontoken = const Uuid().v4();
      final place = await repo.getPlacesDetails(
          placeId: placeId, sessiontoken: sessiontoken);
      state = GetPlaceDetailsSuccess(place: place);
    } catch (e) {
      state = GetPlaceDetailsError(e.toString());
    }
    //
  }

  Future<void> goToMySearchedLocation(PlaceDetailsModel place) async {
    final location = place.geometry!.location!;
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

  void buildSearchedPlaceMarker(PlaceDetailsModel place) {
    final location = place.geometry!.location!;

    Marker marker = Marker(
      markerId: const MarkerId("1"),
      onTap: () {},
      position: LatLng(location.lat!, location.lng!),
      infoWindow: const InfoWindow(title: "searched location"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );
    addMarker(marker);
  }

  void addMarker(Marker marker) {
    markers.add(marker);
    state = AddMarker();
  }
}
