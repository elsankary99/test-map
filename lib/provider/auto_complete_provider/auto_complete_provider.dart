import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_map/data/model/autocomplete_place_model/autocomplete_place_model.dart';
import 'package:test_map/data/repository/place_repo.dart';
import 'package:uuid/uuid.dart';

final inputProvider = StateProvider<String>((ref) => "");
final autoCompleteProvider =
    FutureProvider<List<AutocompletePlaceModel>>((ref) async {
  final repo = ref.read(placeRepoProvider);
  final input = ref.watch(inputProvider);
  final sessiontoken = const Uuid().v4();
  log("input===$input");
  log("sessiontoken===$sessiontoken");
  return await repo.getAutocompletePlaces(
      input: input, sessiontoken: sessiontoken);
});
