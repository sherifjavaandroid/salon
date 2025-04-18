import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easycut_business/app.dart';
import 'package:easycut_business/controller/home/home_controller.dart';
import 'package:easycut_business/core/constant/color.dart';
import 'package:easycut_business/core/constant/dimensions.dart';
import 'package:easycut_business/core/constant/image_asset.dart';
import 'package:easycut_business/core/shared/widgets/big_text.dart';
import 'package:easycut_business/core/shared/widgets/small_text.dart';
import 'package:easycut_business/data/data_source/static/static.dart';
import 'package:easycut_business/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeControllerImp());
    bool isOffline = false;
    Future<void> _checkConnectivity() async {
      final ConnectivityResult connectivityResult =
          (await Connectivity().checkConnectivity()) as ConnectivityResult;
      if (connectivityResult == ConnectivityResult.none) {
        setState(() {
          isOffline = true;
        });
      } else {
        setState(() {
          isOffline = false;
        });
      }
    }

    @override
    void initState() {
      super.initState();
      _checkConnectivity();
    }

    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showExitConfirmationDialog(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<HomeControllerImp>(
          builder: (controller) => SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: Dimensions.height350,
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Stack(
                      children: [
                        Positioned(
                          top: 0,
                          right: 0,
                          left: 0,
                          child: Container(
                              height: constraints.maxHeight * 0.85.h,
                              width: constraints.maxWidth.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft:
                                      Radius.circular(Dimensions.radius20.r),
                                  bottomRight:
                                      Radius.circular(Dimensions.radius20.r),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  bottomLeft:
                                      Radius.circular(Dimensions.radius20.r),
                                  bottomRight:
                                      Radius.circular(Dimensions.radius20.r),
                                ),
                                child: isOffline
                                    ? Image.asset(
                                        'assets/images/local_fallback_image.jpg', // Local image when offline
                                        fit: BoxFit.cover,
                                      )
                                    : controller.image == null
                                        ? CachedNetworkImage(
                                            imageUrl:
                                                'https://th.bing.com/th/id/R.8c774b995a6a4a37ebd962340bc98b5f?rik=73%2fxglMP4%2byw8g&pid=ImgRaw&r=0',
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                const Center(
                                                    child: Text(
                                                        'please check internet ')),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          )
                                        : CachedNetworkImage(
                                            imageUrl:
                                                "${AppLink.imageSalons}${controller.image!}",
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                const Center(
                                              child: CircularProgressIndicator(
                                                strokeWidth:
                                                    5.0, // Make the progress indicator thinner
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                              )),
                        ),
                        Positioned(
                          bottom: -15.h,
                          right: Dimensions.width45.w,
                          left: Dimensions.width45.w,
                          child: Container(
                            height: constraints.maxHeight * 0.25.h,
                            width: constraints.maxWidth.w,
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.circular(
                                Dimensions.radius20.r,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SmallText(
                                  text: "Hello ",
                                  size: Dimensions.font26.sp,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: Dimensions.width5.w,
                                ),
                                BigText(
                                  text: controller.name ?? 'N/A',
                                  size: Dimensions.font32.sp,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: Dimensions.height50.h,
                          right: Dimensions.width15.w,
                          child: Container(
                            height: constraints.maxHeight * 0.15.h,
                            width: constraints.maxWidth * 0.12.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                Dimensions.radius20.r,
                              ),
                            ),
                            child: IconButton(
                              onPressed: () {
                                controller.logout();
                              },
                              icon: const Icon(
                                Icons.logout,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width15.w,
                  ),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: Dimensions.width10.w,
                      mainAxisSpacing: Dimensions.width10.w,
                    ),
                    itemCount: mainHome.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: mainHome[index].taped,
                        child: Card(
                          color: mainHome[index].color,
                          elevation: Dimensions.width10.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                mainHome[index].icon,
                                color: Colors.white,
                                size: Dimensions.width45.w,
                              ),
                              BigText(
                                text: mainHome[index].title,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> showExitConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Exit App'),
          content: const Text('Are you sure you want to exit the app?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Exit'),
            ),
          ],
        );
      },
    );
  }
}
