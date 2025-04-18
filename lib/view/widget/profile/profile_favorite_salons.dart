import 'package:easycut_business/app.dart';
import 'package:easycut_business/core/constant/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileFavoriteSalons extends StatelessWidget {
  const ProfileFavoriteSalons({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.height20.h,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: Dimensions.height15.h,
        crossAxisSpacing: Dimensions.height15.h,
        childAspectRatio: 3 / 4.r,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.red,
        );
      },
    );
  }
}
