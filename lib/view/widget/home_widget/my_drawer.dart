import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_map/core/router/app_router.dart';
import 'package:test_map/core/widget/custom_dialog.dart';
import 'package:test_map/core/widget/custom_toast.dart';
import 'package:test_map/provider/auth_provider/auth_provider.dart';
import 'package:test_map/view/widget/home_widget/drawer_list_tile.dart';
import 'package:test_map/view/widget/home_widget/follow_me_widget.dart';

class MyDrawer extends ConsumerWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(authProvider.notifier);
    ref.listen(
      authProvider,
      (previous, next) {
        if (next is LogOut) {
          context.router.replace(const AuthRoute());
          customToast(title: "LogOut Successfully");
        }
      },
    );
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
        DrawerListTile(
          title: "Log Out",
          onTap: () {
            showMyDialog(context, btnTitle: "LogOut", header: "LogOut",
                onPressed: () {
              provider.logOut();
            }, title: "Are you sure you want to log out?");
          },
          icon: Icons.logout,
          iconColor: Colors.red,
        ),
        const Spacer(),
        const FollowMeWidget()
      ]),
    );
  }
}
