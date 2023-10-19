import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_map/data/model/autocomplete_place_model/autocomplete_place_model.dart';
import 'package:test_map/provider/map_provider/map_provider.dart';

class SearchedPlaceWidget extends ConsumerWidget {
  const SearchedPlaceWidget({
    super.key,
    required this.placeModel,
  });
  final AutocompletePlaceModel placeModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(mapProvider.notifier);
    return ListTile(
      onTap: () async {
        log("place id :${placeModel.placeId!}");
        provider.showDirectionDuration = false;
        provider.controller.close();
        provider.markers.clear();
        provider.result.clear();
        provider.getPlaceName(placeModel);

        await provider.getPlaceDetails(placeModel.placeId!);
        // ref.read(placeIdProvider.notifier).state = placeModel.placeId!;
      },
      leading: const CircleAvatar(
        child: Icon(Icons.place),
      ),
      title: Text(placeModel.description!),
      shape: Border(bottom: BorderSide(color: Colors.grey[300]!, width: 2)),
    );
  }
}
