import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_map/core/constant/app_strings.dart';
import 'package:test_map/data/model/autocomplete_place_model/autocomplete_place_model.dart';
import 'package:test_map/data/model/direction_place_model/direction_place_model.dart';
import 'package:test_map/data/model/place_details_model/place_details_model.dart';

final placeRepoProvider = Provider<PlaceRepo>((ref) {
  return PlaceRepo();
});

class PlaceRepo {
  final dio = Dio();
//! AutocompletePlaces
  Future<List<AutocompletePlaceModel>> getAutocompletePlaces(
      {required String input, required String sessiontoken}) async {
    final res = await dio.get(AppStrings.autoCompleteBaseUrl, queryParameters: {
      "input": input,
      "components": "country:eg",
      "sessiontoken": sessiontoken,
      "types": "address",
      "key": AppStrings.apiKey,
    });

    final data = res.data["predictions"] as List;
    log("=data:=$data==");
    return data.map((e) => AutocompletePlaceModel.fromJson(e)).toList();
  }

//! PlacesDetails
  Future<PlaceDetailsModel> getPlacesDetails(
      {required String placeId, required String sessiontoken}) async {
    final res = await dio.get(AppStrings.placeDetailsBaseUrl, queryParameters: {
      "place_id": placeId,
      "fields": "geometry",
      "sessiontoken": sessiontoken,
      "key": AppStrings.apiKey,
    });

    final data = res.data["result"] as Map<String, dynamic>;
    log("=data:=$data==");
    return PlaceDetailsModel.fromJson(data);
  }

  //! Direction Place
  Future<DirectionPlaceModel> directionPlace(
      {required LatLng destination, required LatLng origin}) async {
    final res = await dio.get(
      AppStrings.directionPlaceBaseUrl,
      queryParameters: {
        "destination": "${destination.latitude},${destination.longitude}",
        "origin": "${origin.latitude},${origin.longitude}",
        "key": AppStrings.apiKey,
      },
    );

    final data = res.data["routes"][0] as Map<String, dynamic>;
    log("=directionPlace:=$data==");
    return DirectionPlaceModel.fromJson(data);
  }
}
