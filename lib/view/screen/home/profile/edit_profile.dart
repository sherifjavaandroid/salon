import 'package:easycut_business/controller/home/profile_controller.dart';
import 'package:easycut_business/core/class/status_request.dart';
import 'package:easycut_business/core/constant/dimensions.dart';
import 'package:easycut_business/core/constant/routes.dart';
import 'package:easycut_business/core/functions/valid_input.dart';
import 'package:easycut_business/core/shared/widgets/big_text.dart';
import 'package:easycut_business/view/widget/auth/custom_button_auth.dart';
import 'package:easycut_business/view/widget/auth/custom_text_form_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProfileControllerImp());
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(
            Get.offNamed(AppRoute.salonProfile) as Route<Object?>);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const BigText(
            text: "Edit Profile",
          ),
          leading: IconButton(
            onPressed: () {
              Get.offNamed(AppRoute.salonProfile);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        body: GetBuilder<ProfileControllerImp>(
          builder: (controller) {
            return Padding(
              padding: EdgeInsets.all(Dimensions.height15),
              child: Form(
                key: controller.formState,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextFormAuth(
                        hintText: "Chairs Number",
                        type: TextInputType.number,
                        prefixIcon: Icons.numbers,
                        myController: controller.chairsNumber,
                        valid: (val) {
                          return validInput(val!, 0, 2, "any");
                        },
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: CustomButtonAuth(
                          onPressed: () async {
                            XFile? xFile = await ImagePicker().pickImage(
                              source: ImageSource.gallery,
                            );
                            controller.addFilePath(xFile!.path);
                          },
                          text: "Select Salon Image",
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: controller.statusRequest == StatusRequest.loading
                            ? CupertinoActivityIndicator()
                            : CustomButtonAuth(
                                onPressed: () {
                                  controller.editProfile();
                                },
                                text: "Edit Profile",
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
