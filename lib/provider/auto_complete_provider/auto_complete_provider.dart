import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_map/data/model/place_model/place_model.dart';
import 'package:test_map/data/repository/auto_complete_place_repo.dart';
import 'package:uuid/uuid.dart';

final inputProvider = StateProvider<String>((ref) => "");
final autoCompleteProvider = FutureProvider<List<PlaceModel>>((ref) async {
  final repo = ref.read(autoCompleteRepoProvider);
  final input = ref.watch(inputProvider);
  final sessiontoken = const Uuid().v4();
  log("input===$input");
  log("sessiontoken===$sessiontoken");
  return await repo.getSamePlaces(input: input, sessiontoken: sessiontoken);
});
