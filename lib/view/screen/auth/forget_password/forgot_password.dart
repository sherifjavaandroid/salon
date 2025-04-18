import 'package:easycut_business/controller/auth/forget_password_controller.dart';
import 'package:easycut_business/core/class/handling_data_view.dart';
import 'package:easycut_business/core/constant/dimensions.dart';
import 'package:easycut_business/core/functions/valid_input.dart';
import 'package:easycut_business/view/widget/auth/custom_button_auth.dart';
import 'package:easycut_business/view/widget/auth/custom_text_form_auth.dart';
import 'package:easycut_business/view/widget/auth/header_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.width15,
          vertical: Dimensions.height15,
        ),
        child: GetBuilder<ForgetPasswordControllerImp>(
          builder: (controller) {
            return HandlingDataRequest(
              statusRequest: controller.statusRequest,
              widget: Form(
                key: controller.formState,
                child: ListView(
                  children: [
                    HeaderAuth(
                      title: "23".tr,
                      firstDesc: "24".tr,
                      secondDesc: "25".tr,
                    ),
                    CustomTextFormAuth(
                      myController: controller.email,
                      valid: (val) {
                        return validInput(val!, 15, 100, 'email');
                      },
                      type: TextInputType.emailAddress,
                      hintText: "17".tr,
                      prefixIcon: Icons.email,
                    ),
                    CustomButtonAuth(
                      onPressed: () {
                        controller.checkEmail();
                      },
                      text: "26".tr,
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
