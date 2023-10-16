import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    this.icon,
    required this.title,
    this.onTap,
    this.iconColor,
  });
  final IconData? icon;
  final Color? iconColor;
  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      onTap: onTap,
      leading: Icon(
        icon,
        color: iconColor ?? Colors.blue,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_sharp,
        color: iconColor ?? Colors.blue,
        size: 16.sp,
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 14.sp),
      ),
    );
  }
}
