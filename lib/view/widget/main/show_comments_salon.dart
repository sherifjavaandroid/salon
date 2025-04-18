import 'package:easycut_business/app.dart';
import 'package:easycut_business/controller/home/comments_controller.dart';
import 'package:easycut_business/core/constant/dimensions.dart';
import 'package:easycut_business/core/shared/widgets/big_text.dart';
import 'package:easycut_business/core/shared/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ShowCommentsSalon extends StatelessWidget {
  const ShowCommentsSalon({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CommentsControllerImp());
    return GetBuilder<CommentsControllerImp>(
      builder: (controller) {
        return LayoutBuilder(
          builder: (context, constr) {
            return SizedBox(
              height: constr.maxHeight,
              width: constr.maxWidth,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(
                  vertical: Dimensions.height20.h,
                ),
                // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //   crossAxisCount: 2,
                //   mainAxisSpacing: Dimensions.height15,
                //   crossAxisSpacing: Dimensions.height15,
                //   childAspectRatio: 3 / 4,
                // ),
                itemCount: controller.comments.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: Dimensions.height150.h,
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(Dimensions.height15.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(
                              text: controller.comments[index].name!,
                            ),
                            BigText(
                              text: controller.comments[index].phone!,
                              size: Dimensions.font16,
                            ),
                            SizedBox(
                              height: Dimensions.height10.h,
                            ),
                            Expanded(
                              child: SmallText(
                                text: controller.comments[index].body!,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
