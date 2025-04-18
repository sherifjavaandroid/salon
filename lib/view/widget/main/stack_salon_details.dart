import 'package:easycut_business/app.dart';
import 'package:easycut_business/core/constant/color.dart';
import 'package:easycut_business/core/constant/dimensions.dart';
import 'package:easycut_business/data/model/salon_model.dart';
import 'package:easycut_business/view/widget/home/show_salon_card.dart';
import 'package:easycut_business/view/widget/main/about_salon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StackSalonDetails extends StatelessWidget {
  final SalonModel salon;
  const StackSalonDetails({
    super.key,
    required this.salon,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: Dimensions.height350.h - Dimensions.height70.h,
      left: 0,
      right: 0,
      bottom: 0,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Container(
                height: constraints.maxHeight.h,
                width: constraints.maxWidth.w,
                padding: EdgeInsets.only(
                  right: Dimensions.width20.w,
                  left: Dimensions.width20.w,
                  top: Dimensions.height20.w,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius30.r),
                    topLeft: Radius.circular(Dimensions.radius30.r),
                  ),
                ),
                child: DefaultTabController(
                  length: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShowSalonCard(
                        text: "${salon.name}",
                        phone: "${salon.phone}",
                        rate: salon.rate ?? 0,
                      ),
                      SizedBox(height: Dimensions.height10.h),
                      TabBar(
                        labelColor: AppColor.primaryColor,
                        unselectedLabelColor: Colors.grey[700],
                        indicatorColor: AppColor.primaryColor,
                        tabs: const [
                          Tab(
                            text: "About",
                          ),
                          // Tab(
                          //   text: "Comments",
                          // ),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            AboutSalon(
                              address: salon.address ?? 'N/A',
                              city: salon.city ?? 'N/A',
                              country: salon.country ?? 'N/A',
                              email: salon.email ?? 'N/A',
                              chairs: (salon.chairs ?? '').toString().isEmpty
                                  ? 'N/A'
                                  : salon.chairs.toString(),
                              subscription:
                                  (salon.subscription ?? '').toString().isEmpty
                                      ? 'N/A'
                                      : salon.subscription.toString(),
                              created: (salon.createdAt ?? '').isEmpty
                                  ? 'N/A'
                                  : salon.createdAt!.substring(0, 10),
                            ),
                            //ShowCommentsSalon(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
