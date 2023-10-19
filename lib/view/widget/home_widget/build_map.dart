import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_map/helper/location_helper.dart';
import 'package:test_map/provider/map_provider/map_provider.dart';

final currentFutureProvider = FutureProvider<Position>((ref) async {
  return LocationHelper.getCurrentLocation();
});

class BuildMap extends ConsumerWidget {
  const BuildMap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(mapProvider.notifier);
    ref.watch(mapProvider);
    return ref.watch(currentFutureProvider).when(
          data: (data) => GoogleMap(
            // polylines: {Polyline(polylineId: polylineId)},
            markers: provider.markers,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
                zoom: 17, target: LatLng(data.latitude, data.longitude)),
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              provider.mapController.complete(controller);
            },
          ),
          error: (error, stackTrace) => Center(child: Text("$error")),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}
