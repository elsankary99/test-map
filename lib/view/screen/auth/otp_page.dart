import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_map/core/constant/app_strings.dart';
import 'package:test_map/core/widget/custom_button.dart';
import 'package:test_map/view/widget/auth_widet/otp_code_field.dart';
import 'package:test_map/view/widget/auth_widet/otp_top_text.dart';

@RoutePage()
class OTPPage extends ConsumerWidget {
  const OTPPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: OTPTopText()),
            const SliverToBoxAdapter(child: OTPCodeField()),
            SliverToBoxAdapter(child: SizedBox(height: 80.h)),
            SliverToBoxAdapter(
              child: CustomButton(
                title: AppStrings.next,
                onPressed: () async {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
