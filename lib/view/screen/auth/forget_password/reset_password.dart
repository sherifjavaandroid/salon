import 'package:easycut_business/controller/auth/reset_password_controller.dart';
import 'package:easycut_business/core/class/handling_data_view.dart';
import 'package:easycut_business/core/constant/dimensions.dart';
import 'package:easycut_business/core/functions/valid_input.dart';
import 'package:easycut_business/view/widget/auth/custom_button_auth.dart';
import 'package:easycut_business/view/widget/auth/custom_text_form_auth.dart';
import 'package:easycut_business/view/widget/auth/header_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.width15,
          vertical: Dimensions.height15,
        ),
        child: GetBuilder<ResetPasswordControllerImp>(
          builder: (controller) {
            return HandlingDataRequest(
              statusRequest: controller.statusRequest,
              widget: Form(
                key: controller.formState,
                child: ListView(
                  children: [
                    HeaderAuth(
                      title: "30".tr,
                      firstDesc: "31".tr,
                      secondDesc: "32".tr,
                    ),
                    CustomTextFormAuth(
                      myController: controller.password,
                      valid: (val) {
                        return validInput(val!, 6, 30, 'password');
                      },
                      type: TextInputType.visiblePassword,
                      obSecure: controller.isShowPassword,
                      hintText: "18".tr,
                      prefixIcon: Icons.lock,
                      suffixIcon: controller.isShowPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      suffixPressed: () {
                        controller.showPassword();
                      },
                    ),
                    CustomTextFormAuth(
                      myController: controller.confirmPassword,
                      valid: (val) {
                        return validInput(val!, 6, 30, 'password');
                      },
                      type: TextInputType.visiblePassword,
                      obSecure: controller.isShowPassword,
                      hintText: "33".tr,
                      prefixIcon: Icons.lock,
                      suffixIcon: controller.isShowPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      suffixPressed: () {
                        controller.showPassword();
                      },
                    ),
                    CustomButtonAuth(
                      onPressed: () {
                        controller.resetPassword();
                      },
                      text: "30".tr,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
