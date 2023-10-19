import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:test_map/data/model/direction_place_model/direction_place_model.dart';
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
  bool showDirectionDuration = false;
  bool hideDirectionDurationIcon = true;
  void hideDirectionDuration(bool hide) {
    log("hide:$hide");
    hideDirectionDurationIcon = hide;
    state = HideDirectionDuration();
  }

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
      onTap: () {
        showDirectionDuration = true;
        state = ShowDirectionDuration();

        log("showDirectionDuration");
      },
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

  //! Direction Place
  Future<void> getDirectionPlace(PlaceDetailsModel place) async {
    state = DirectionPlaceLoading();
    log("DirectionPlaceLoading");
    try {
      final location = place.geometry!.location!;
      final origin = await LocationHelper.getCurrentLocation();
      final direction = await repo.directionPlace(
        destination: LatLng(location.lat!, location.lng!),
        origin: LatLng(origin.latitude, origin.longitude),
      );
      state = DirectionPlaceSuccess(direction: direction);
      log("DirectionPlaceSuccess");
    } catch (e) {
      state = DirectionPlaceError(e.toString());
      log("DirectionPlace: ${e.toString()}");
    }
  }
}
