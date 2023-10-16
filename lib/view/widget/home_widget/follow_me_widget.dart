import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test_map/view/widget/home_widget/social_media_widget.dart';

class FollowMeWidget extends StatelessWidget {
  const FollowMeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "Follow Me",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
          ),
        ),
        const Row(
          children: [
            SocialMediaWidget(
              icon: FontAwesomeIcons.squareFacebook,
            ),
            SocialMediaWidget(
              icon: FontAwesomeIcons.telegram,
            ),
            SocialMediaWidget(
              icon: FontAwesomeIcons.linkedin,
            ),
          ],
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
