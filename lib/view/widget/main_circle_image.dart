import 'package:easycut_business/core/constant/dimensions.dart';
import 'package:easycut_business/core/constant/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainCircleImage extends StatelessWidget {
  final String image;
  const MainCircleImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height100.h,
      width: Dimensions.height100.w,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          Dimensions.radius50.r,
        ),
        child: Image.asset(
          AppImageAsset.profile,
          fit: BoxFit.cover,
        ),
        // child: Image.network(
        //   image,
        //   fit: BoxFit.cover,
        // ),
      ),
    );
  }
}
