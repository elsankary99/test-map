import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_map/data/model/place_details_model/place_details_model.dart';
import 'package:test_map/data/repository/place_repo.dart';
import 'package:uuid/uuid.dart';

final placeIdProvider = StateProvider<String>((ref) => "");
final placeDetailsProvider = FutureProvider<PlaceDetailsModel>((ref) async {
  final repo = ref.read(placeRepoProvider);
  final placeId = ref.watch(placeIdProvider);
  final sessiontoken = const Uuid().v4();
  log("input===$placeId");
  log("sessiontoken===$sessiontoken");
  return await repo.getPlacesDetails(
      placeId: placeId, sessiontoken: sessiontoken);
});
