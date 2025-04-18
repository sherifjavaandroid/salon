import 'package:easycut_business/core/constant/dimensions.dart';
import 'package:easycut_business/core/shared/widgets/big_text.dart';
import 'package:easycut_business/core/shared/widgets/small_text.dart';
import 'package:easycut_business/view/widget/main_circle_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartProfile extends StatelessWidget {
  final String userName;
  final String userImage;
  final String userEmail;
  final void Function() update;
  const CartProfile({
    super.key,
    required this.userName,
    required this.userImage,
    required this.userEmail,
    required this.update,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(Dimensions.height15.h),
          child: Column(
            children: [
              SizedBox(
                height: 100.h,
                child: Row(
                  children: [
                    MainCircleImage(image: userImage),
                    SizedBox(width: Dimensions.width20.w),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              BigText(
                                text: userName,
                              ),
                              // Spacer(),
                              IconButton(
                                onPressed: update,
                                icon: const Icon(Icons.edit),
                              ),
                            ],
                          ),
                          SmallText(text: userEmail)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
