import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_map/core/constant/app_strings.dart';
import 'package:test_map/core/router/app_router.dart';
import 'package:test_map/core/widget/custom_button.dart';
import 'package:test_map/core/widget/custom_toast.dart';
import 'package:test_map/provider/auth_provider/auth_provider.dart';
import 'package:test_map/view/widget/auth_widet/otp_code_field.dart';
import 'package:test_map/view/widget/auth_widet/otp_top_text.dart';

@RoutePage()
class OTPPage extends ConsumerWidget {
  const OTPPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final state = ref.watch(authProvider);
    final provider = ref.read(authProvider.notifier);
    final state = ref.watch(authProvider);
    ref.listen(
      authProvider,
      (previous, next) {
        if (next is AuthError) {
          customToast(title: next.message, color: Colors.red);
        }
        if (next is PhoneOtpVerified) {
          context.router.replace(const MapRoute());
          customToast(title: "Welcome To Our App 🤍");
        }
      },
    );
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
                title: AppStrings.verify,
                onPressed: () async {
                  await provider.submitOtp();
                },
                child: state is SubmitLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : null,
              ),
            )
          ],
        ),
      ),
    );
  }
}
