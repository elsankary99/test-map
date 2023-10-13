import 'package:flutter/material.dart';
import 'package:test_map/core/constant/app_strings.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          hintText: AppStrings.enterYourNumber,
          border: OutlineInputBorder()),
    );
  }
}
