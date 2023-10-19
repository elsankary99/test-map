import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DirectionPlaceInfoWidget extends StatelessWidget {
  const DirectionPlaceInfoWidget({
    super.key,
    required this.title,
    required this.icon,
  });
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110.w,
      height: 50.h,
      child: Card(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 4.w),
          Icon(
            icon,
            color: Colors.blue,
            size: 30.sp,
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontSize: 16.sp),
            ),
          )
        ],
      )),
    );
  }
}
