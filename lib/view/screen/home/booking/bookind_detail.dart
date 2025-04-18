import 'package:easycut_business/controller/home/booking_detail_controller.dart';
import 'package:easycut_business/core/class/handling_data_view.dart';
import 'package:easycut_business/core/constant/dimensions.dart';
import 'package:easycut_business/core/constant/routes.dart';
import 'package:easycut_business/core/shared/widgets/big_text.dart';
import 'package:easycut_business/core/shared/widgets/small_text.dart';
import 'package:easycut_business/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingDetail extends StatelessWidget {
  const BookingDetail({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => BookingDetailControllerImp());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const BigText(
          text: "Booking Detail",
          color: Colors.black,
        ),
        leading: IconButton(
          onPressed: () {
            Get.offNamed(AppRoute.home);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: GetBuilder<BookingDetailControllerImp>(
        builder: (controller) {
          return HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: Container(
              width: double.infinity,
              margin: EdgeInsets.all(Dimensions.height10),
              child: Padding(
                padding: EdgeInsets.all(Dimensions.height10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: Dimensions.height45,
                          child: ClipRRect(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            borderRadius: BorderRadius.circular(
                              Dimensions.height45,
                            ),
                            child: Image.network(
                              "${AppLink.imageUsers}${controller.bookingModel.userImage}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.width10,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(
                                text: controller.bookingModel.day!,
                                size: Dimensions.font16,
                              ),
                              BigText(
                                text: controller.bookingModel.startTime!,
                                size: Dimensions.font16,
                                color: Colors.red,
                              ),
                              BigText(
                                text: controller.bookingModel.userName!,
                                size: Dimensions.font20,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                const SmallText(text: "Price :"),
                                SizedBox(width: Dimensions.width5),
                                BigText(
                                  text: "${controller.bookingModel.total!} \$",
                                  size: Dimensions.font16,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  height: Dimensions.height15,
                                  width: Dimensions.height15,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _getApprovalColor(
                                      controller.bookingModel.approve!
                                          .toString(),
                                    ),
                                  ),
                                ),
                                SizedBox(width: Dimensions.width5),
                                BigText(
                                  text: _getApprovalText(
                                    controller.bookingModel.approve.toString(),
                                  ),
                                  size: Dimensions.font16,
                                  color: _getApprovalColor(
                                    controller.bookingModel.approve.toString(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Divider(),
                    SizedBox(
                      height: Dimensions.height200,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.services.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: Dimensions.height200,
                            width: Dimensions.height250,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  "${AppLink.imageServices}${controller.services[index].image}",
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  color: Colors.black45,
                                  padding: EdgeInsets.all(Dimensions.width5),
                                  child: BigText(
                                    text: controller.services[index].name!,
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  color: Colors.black45,
                                  padding: EdgeInsets.all(Dimensions.width5),
                                  child: BigText(
                                    text:
                                        "${controller.services[index].price!} \$",
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
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
  }

  // Function to get the appropriate color based on the approval status
  Color _getApprovalColor(String approve) {
    switch (approve) {
      case "0":
        return Colors.orange;
      case "1":
        return Colors.green;
      case "2":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Function to get the appropriate text based on the approval status
  String _getApprovalText(String approve) {
    switch (approve) {
      case "0":
        return "waiting";
      case "1":
        return "accepted";
      case "2":
        return "refused";
      default:
        return "unknown";
    }
  }
}
