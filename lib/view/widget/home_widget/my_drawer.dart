import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_map/view/widget/home_widget/drawer_list_tile.dart';
import 'package:test_map/view/widget/home_widget/follow_me_widget.dart';

class MyDrawer extends ConsumerWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: Column(children: [
        Container(
          height: 180.h,
          width: double.infinity,
          color: Colors.blue,
          child: Center(
            child: Image.asset(
              "assets/images/logo.png",
              color: Colors.white,
              height: 100.h,
              // width: 80,
              // fit: BoxFit.fill,
            ),
          ),
        ),
        const DrawerListTile(
          title: "My Profile",
          icon: Icons.person,
        ),
        const DrawerListTile(
          title: "Saved Places",
          icon: Icons.bookmark,
        ),
        const DrawerListTile(
          title: "Log Out",
          icon: Icons.logout,
          iconColor: Colors.red,
        ),
        const Spacer(),
        const FollowMeWidget()
      ]),
    );
  }
}
