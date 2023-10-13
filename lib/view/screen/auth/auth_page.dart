import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_map/view/widget/auth_widet/auth_top_text.dart';
import 'package:test_map/view/widget/auth_widet/country_code.dart';
import 'package:test_map/view/widget/auth_widet/custom_text_form_field.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              const SliverToBoxAdapter(child: AuthTopText()),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 45.h,
                  child: Row(
                    children: [
                      const Expanded(flex: 1, child: CountryCode()),
                      SizedBox(width: 10.w),
                      const Expanded(flex: 3, child: CustomTextFormField()),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 80.h)),
              SliverToBoxAdapter(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 85.w,
                    height: 40.h,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      child: const Text("Next"),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
