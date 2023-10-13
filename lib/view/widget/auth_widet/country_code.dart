import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_map/core/function/country_flag.dart';

class CountryCode extends StatelessWidget {
  const CountryCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          " $countryFlag ",
          style: TextStyle(fontSize: 16.sp),
        ),
        Text(
          "+20",
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
        const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.blueGrey)
      ]),
    );
  }
}
