import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:test_map/provider/auto_complete_provider/auto_complete_provider.dart';
import 'package:test_map/provider/map_provider/map_provider.dart';

class FloatingSearchBarWidget extends ConsumerWidget {
  const FloatingSearchBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(mapProvider.notifier);

    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      margins: EdgeInsets.only(top: 40.h, left: 16.w, right: 16.w),
      controller: provider.controller,
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        ref.read(inputProvider.notifier).state = query;
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: ref.watch(autoCompleteProvider).when(
                  data: (data) {
                    if (data.isNotEmpty) {
                      return SizedBox(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const ClampingScrollPhysics(),
                          itemCount: data.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: const CircleAvatar(
                                child: Icon(Icons.place),
                              ),
                              title: Text(data[index].description!),
                              shape: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey[300]!, width: 2)),
                            );
                          },
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                  error: (error, stackTrace) =>
                      Center(child: Text(error.toString())),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
          ),
        );
      },
    );
  }
}
