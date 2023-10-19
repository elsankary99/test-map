import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_map/provider/map_provider/map_provider.dart';
import 'package:test_map/view/widget/home_widget/direction_place_info.dart';

class DistanceAndDurationWidget extends ConsumerWidget {
  const DistanceAndDurationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(mapProvider.notifier);
    ref.watch(mapProvider);

    return Visibility(
      visible: (provider.showDirectionDuration == true &&
              provider.hideDirectionDurationIcon == true)
          ? true
          : false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DirectionPlaceInfoWidget(
                icon: Icons.time_to_leave,
                title: provider.direction?.legs![0].distance!.text! ?? ""),
            DirectionPlaceInfoWidget(
                icon: Icons.access_time_filled_sharp,
                title: provider.direction?.legs![0].duration!.text! ?? ""),
          ],
        ),
      ),
    );
  }
}
