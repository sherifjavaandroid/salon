import 'package:easycut_business/app.dart';
import 'package:easycut_business/core/constant/dimensions.dart';
import 'package:easycut_business/core/shared/widgets/big_text.dart';
import 'package:easycut_business/core/shared/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutSalon extends StatelessWidget {
  final String email;
  final String country;
  final String city;
  final String address;
  final String chairs;
  final String subscription;
  final String created;
  const AboutSalon({
    super.key,
    required this.email,
    required this.country,
    required this.city,
    required this.address,
    required this.chairs,
    required this.subscription,
    required this.created,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Dimensions.height10.h),
        const BigText(text: "Email"),
        SizedBox(height: Dimensions.height10.h),
        SmallText(text: email),
        SizedBox(height: Dimensions.height10.h),
        const BigText(text: "Address"),
        SizedBox(height: Dimensions.height10.h),
        SmallText(text: "$country || $city || $address"),
        SizedBox(height: Dimensions.height10.h),
        const BigText(text: "Chairs"),
        SizedBox(height: Dimensions.height10.h),
        SmallText(text: chairs),
        SizedBox(height: Dimensions.height10.h),
        const BigText(text: "Subscription"),
        SizedBox(height: Dimensions.height10.h),
        SmallText(text: "$subscription Months"),
        SizedBox(height: Dimensions.height10.h),
        const BigText(text: "Started At"),
        SizedBox(height: Dimensions.height10.h),
        SmallText(text: created),
        SizedBox(height: Dimensions.height10.h),
      ],
    );
  }
}
