import 'package:easycut_business/controller/auth/login_controller.dart';
import 'package:easycut_business/core/class/handling_data_view.dart';
import 'package:easycut_business/core/constant/color.dart';
import 'package:easycut_business/core/constant/dimensions.dart';
import 'package:easycut_business/core/functions/alert_exit.dart';
import 'package:easycut_business/core/functions/valid_input.dart';
import 'package:easycut_business/view/widget/auth/custom_button_auth.dart';
import 'package:easycut_business/view/widget/auth/custom_text_form_auth.dart';
import 'package:easycut_business/view/widget/auth/header_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:country_picker/country_picker.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: WillPopScope(
          onWillPop: alertExit,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.width15,
              vertical: Dimensions.height15,
            ),
            child: GetBuilder<LoginControllerImp>(
              builder: (controller) {
                return HandlingDataRequest(
                  statusRequest: controller.statusRequest,
                  widget: Column(
                    children: [
                      HeaderAuth(
                        title: "14".tr,
                        firstDesc: "15".tr,
                        secondDesc: "16".tr,
                      ),

                      SizedBox(height: Dimensions.height30),

                      // Custom Tab Bar
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  controller.tabController.animateTo(0);
                                  controller.update();
                                },
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: controller.tabController.index == 0
                                        ? Colors.white
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(22),
                                    boxShadow: controller.tabController.index == 0
                                        ? [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: Offset(0, 1),
                                      ),
                                    ]
                                        : [],
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Email",
                                      style: TextStyle(
                                        fontSize: Dimensions.font12,
                                        fontWeight: controller.tabController.index == 0
                                            ? FontWeight.w600
                                            : FontWeight.normal,
                                        color: controller.tabController.index == 0
                                            ? Colors.black87
                                            : Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  controller.tabController.animateTo(1);
                                  controller.update();
                                },
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: controller.tabController.index == 1
                                        ? Color(0xFF4A6FA5)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(22),
                                    boxShadow: controller.tabController.index == 1
                                        ? [
                                      BoxShadow(
                                        color: Color(0xFF4A6FA5).withOpacity(0.3),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: Offset(0, 1),
                                      ),
                                    ]
                                        : [],
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Phone Number",
                                      style: TextStyle(
                                        fontSize: Dimensions.font12,
                                        fontWeight: controller.tabController.index == 1
                                            ? FontWeight.w600
                                            : FontWeight.normal,
                                        color: controller.tabController.index == 1
                                            ? Colors.white
                                            : Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: Dimensions.height20),

                      // Tab Bar View
                      Expanded(
                        child: TabBarView(
                          controller: controller.tabController,
                          children: [
                            // Email Login Form
                            _buildEmailLoginForm(controller),
                            // Phone Login Form
                            _buildPhoneLoginForm(controller),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailLoginForm(LoginControllerImp controller) {
    return Form(
      key: controller.emailFormState,
      child: ListView(
        children: [
          CustomTextFormAuth(
            myController: controller.email,
            valid: (val) {
              return validInput(val!, 15, 100, 'email');
            },
            type: TextInputType.emailAddress,
            hintText: "17".tr,
            prefixIcon: Icons.email,
          ),

          CustomTextFormAuth(
            myController: controller.emailPassword,
            valid: (val) {
              return validInput(val!, 6, 20, 'password');
            },
            type: TextInputType.visiblePassword,
            obSecure: controller.isShowEmailPassword,
            suffixPressed: () {
              controller.showEmailPassword();
            },
            hintText: "18".tr,
            prefixIcon: Icons.lock,
            suffixIcon: controller.isShowEmailPassword
                ? Icons.visibility
                : Icons.visibility_off,
          ),

          GestureDetector(
            onTap: () {
              controller.goToForgetPassword();
            },
            child: Text(
              "19".tr,
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: AppColor.grey,
              ),
            ),
          ),

          CustomButtonAuth(
            onPressed: () {
              controller.loginWithEmail();
            },
            text: "20".tr,
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneLoginForm(LoginControllerImp controller) {
    return Form(
      key: controller.phoneFormState,
      child: ListView(
        children: [
          // Country Code + Phone Field
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  showCountryPicker(
                    context: Get.context!,
                    showPhoneCode: true,
                    onSelect: (Country country) {
                      controller.countryCode.text = "+${country.phoneCode}";
                      controller.update();
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width10,
                      vertical: Dimensions.height10
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Text(
                        controller.countryCode.text.isEmpty
                            ? "+20" // default to Egypt
                            : controller.countryCode.text,
                        style: TextStyle(fontSize: Dimensions.font16),
                      ),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),

              SizedBox(width: Dimensions.width10),

              Expanded(
                child: CustomTextFormAuth(
                  myController: controller.phone,
                  valid: (val) {
                    return validInput(val!, 5, 15, 'phone');
                  },
                  type: TextInputType.phone,
                  hintText: "Phone Number",
                  prefixIcon: Icons.phone,
                ),
              ),
            ],
          ),

          CustomTextFormAuth(
            myController: controller.phonePassword,
            valid: (val) {
              return validInput(val!, 6, 20, 'password');
            },
            type: TextInputType.visiblePassword,
            obSecure: controller.isShowPhonePassword,
            suffixPressed: () {
              controller.showPhonePassword();
            },
            hintText: "18".tr,
            prefixIcon: Icons.lock,
            suffixIcon: controller.isShowPhonePassword
                ? Icons.visibility
                : Icons.visibility_off,
          ),

          GestureDetector(
            onTap: () {
              controller.goToForgetPassword();
            },
            child: Text(
              "19".tr,
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: AppColor.grey,
              ),
            ),
          ),

          CustomButtonAuth(
            onPressed: () {
              controller.loginWithPhone();
            },
            text: "20".tr,
          ),
        ],
      ),
    );
  }
}