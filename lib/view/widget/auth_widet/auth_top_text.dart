import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_map/core/constant/app_strings.dart';

class AuthTopText extends StatelessWidget {
  const AuthTopText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 80.h),
        Text(
          AppStrings.whatIsYourNumber,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 22.h),
        Text(AppStrings.pleaseEnterYourNumber,
            style: TextStyle(fontSize: 14.sp)),
        SizedBox(height: 80.h),
      ],
    );
  }
}
