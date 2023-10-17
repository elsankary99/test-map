import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_map/core/constant/app_strings.dart';
import 'package:test_map/data/model/place_model/place_model.dart';

final autoCompleteRepoProvider = Provider<AutoCompletePlaceRepo>((ref) {
  return AutoCompletePlaceRepo();
});

class AutoCompletePlaceRepo {
  final dio = Dio();

  Future<List<PlaceModel>> getSamePlaces(
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
    return data.map((e) => PlaceModel.fromJson(e)).toList();
  }
}
