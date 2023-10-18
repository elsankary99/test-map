import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_map/core/widget/custom_toast.dart';
import 'package:test_map/provider/map_provider/map_provider.dart';
import 'package:test_map/view/widget/home_widget/build_map.dart';
import 'package:test_map/view/widget/home_widget/floating_searchbar_widget.dart';
import 'package:test_map/view/widget/home_widget/my_drawer.dart';

@RoutePage()
class MapPage extends ConsumerWidget {
  const MapPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(mapProvider.notifier);
    ref.listen(
      mapProvider,
      (previous, next) async {
        if (next is GetPlaceDetailsError) {
          customToast(title: next.message, color: Colors.red);
        }
        if (next is GetPlaceDetailsSuccess) {
          provider.buildSearchedPlaceMarker(next.location);
          await provider.goToMySearchedLocation(next.location);
        }
      },
    );
    return Scaffold(
      drawer: const MyDrawer(),
      body: const Stack(
        fit: StackFit.expand,
        children: [
          BuildMap(),
          FloatingSearchBarWidget(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: provider.moveToMyCurrentPosition,
        child: const Icon(Icons.place),
      ),
    );
  }
}
