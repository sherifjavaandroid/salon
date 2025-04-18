import 'package:easycut_business/app.dart';
import 'package:easycut_business/core/constant/color.dart';
import 'package:easycut_business/core/constant/dimensions.dart';
import 'package:easycut_business/core/shared/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewestText extends StatelessWidget {
  final String title;
  const NewestText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.width20.w,
        right: Dimensions.width20.w,
        bottom: Dimensions.height10.h,
      ),
      child: BigText(
        text: title,
        color: AppColor.primaryColor,
        size: Dimensions.font26.sp,
      ),
    );
  }
}
