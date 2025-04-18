import 'package:easycut_business/app.dart';
import 'package:easycut_business/core/constant/dimensions.dart';
import 'package:easycut_business/core/constant/image_asset.dart';
import 'package:easycut_business/core/shared/widgets/big_text.dart';
import 'package:easycut_business/core/shared/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderMainView extends StatelessWidget {
  final String? image;
  final String name;
  const HeaderMainView({
    super.key,
    required this.name,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.height60.h,
      child: Row(
        children: [
          image == null
              ? CircleAvatar(
                  radius: Dimensions.radius30.r,
                  backgroundImage: const AssetImage(
                    AppImageAsset.profile,
                  ),
                )
              : Container(
                  height: Dimensions.height60.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(image!),
                ),
          SizedBox(width: Dimensions.width10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmallText(
                text: "Hello",
                color: Colors.black,
                size: Dimensions.font16.sp,
              ),
              BigText(
                text: name,
                color: Colors.black,
                size: Dimensions.font20.sp,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
