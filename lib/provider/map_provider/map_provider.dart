import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';

part 'map_state.dart';

final mapProvider =
    StateNotifierProvider<MapProvider, MapState>((ref) => MapProvider());

class MapProvider extends StateNotifier<MapState> {
  MapProvider() : super(MapInitial());
  FloatingSearchBarController controller = FloatingSearchBarController();
}
