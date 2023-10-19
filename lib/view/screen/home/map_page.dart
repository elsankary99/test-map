import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_map/core/widget/custom_toast.dart';
import 'package:test_map/provider/map_provider/map_provider.dart';
import 'package:test_map/view/widget/home_widget/build_map.dart';
import 'package:test_map/view/widget/home_widget/duration_direction_widget.dart';
import 'package:test_map/view/widget/home_widget/floating_searchbar_widget.dart';
import 'package:test_map/view/widget/home_widget/my_drawer.dart';

@RoutePage()
class MapPage extends ConsumerWidget {
  const MapPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(mapProvider.notifier);
    ref.watch(mapProvider);
    ref.listen(
      mapProvider,
      (previous, next) async {
        if (next is GetPlaceDetailsError) {
          customToast(title: next.message, color: Colors.red);
        }
        if (next is GetPlaceDetailsSuccess) {
          provider.buildSearchedPlaceMarker(next.place);
          await provider.goToMySearchedLocation(next.place);
          await provider.getDirectionPlace(next.place);
        }
      },
    );
    return Scaffold(
      drawer: const MyDrawer(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const BuildMap(),
          const FloatingSearchBarWidget(),
          Positioned(
              left: 0,
              right: 0,
              top: 100.h,
              child: const DistanceAndDurationWidget())
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: provider.moveToMyCurrentPosition,
        child: const Icon(Icons.place),
      ),
    );
  }
}
