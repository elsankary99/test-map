import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> showMyDialog(BuildContext context,
    {required String header,
    required String title,
    required String btnTitle,
    required void Function()? onPressed}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(header),
        backgroundColor: Theme.of(context).canvasColor,
        content: Text(
          title,
          style: TextStyle(fontSize: 16.sp, color: Colors.grey)
              .copyWith(color: Colors.grey),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        context.router.pop();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).canvasColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(color: Colors.grey))),
                      child: Text(
                        "No",
                        style: TextStyle(fontSize: 16.sp, color: Colors.black),
                      )),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: ElevatedButton(
                      onPressed: onPressed,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                      child: Text(
                        btnTitle,
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      )),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
