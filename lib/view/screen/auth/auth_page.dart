import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_map/core/constant/app_strings.dart';
import 'package:test_map/core/router/app_router.dart';
import 'package:test_map/core/widget/custom_button.dart';
import 'package:test_map/core/widget/custom_toast.dart';
import 'package:test_map/provider/auth_provider/auth_provider.dart';
import 'package:test_map/view/widget/auth_widet/auth_top_text.dart';
import 'package:test_map/view/widget/auth_widet/country_code.dart';
import 'package:test_map/view/widget/auth_widet/custom_text_form_field.dart';

@RoutePage()
class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(authProvider.notifier);
    final state = ref.watch(authProvider);
    ref.listen(
      authProvider,
      (previous, next) {
        if (next is AuthError) {
          customToast(title: next.message, color: Colors.red);
        }
        if (next is PhoneNumberSubmitted) {
          router.push(const OTPRoute());
          customToast(title: "We send code to phone number");
        }
      },
    );
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(flex: 1, child: CountryCode()),
                    SizedBox(width: 10.w),
                    const Expanded(flex: 3, child: CustomTextFormField()),
                  ],
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 80.h)),
              SliverToBoxAdapter(
                child: CustomButton(
                  title: AppStrings.next,
                  onPressed: () async {
                    await provider.signUpWithPhoneNumber();
                    // router.push(const OTPRoute());
                  },
                  child: state is AuthLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : null,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
