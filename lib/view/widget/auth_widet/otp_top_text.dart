import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_map/core/constant/app_strings.dart';
import 'package:test_map/provider/auth_provider/auth_provider.dart';

class OTPTopText extends ConsumerWidget {
  const OTPTopText({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(authProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 80.h),
        Text(
          AppStrings.verifyYourNumber,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 22.h),
        RichText(
          text: TextSpan(
              text: AppStrings.enterYour6DigitCode,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black,
                height: 1.7,
              ),
              children: [
                TextSpan(
                    text: "+2${provider.phoneNumber}",
                    style: TextStyle(fontSize: 14.sp, color: Colors.blue))
              ]),
        ),
        SizedBox(height: 80.h),
      ],
    );
  }
}
