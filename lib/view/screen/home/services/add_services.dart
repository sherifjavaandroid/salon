import 'package:easycut_business/controller/home/services_controller.dart';
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

class AddServices extends StatelessWidget {
  const AddServices({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ServicesControllerImp());
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context)
            .pushReplacement(Get.offNamed(AppRoute.services) as Route<Object?>);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const BigText(
            text: "Add Services",
          ),
          leading: IconButton(
            onPressed: () {
              Get.offNamed(AppRoute.services);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        body: GetBuilder<ServicesControllerImp>(
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
                        hintText: "Service Name (Hair Cut)",
                        type: TextInputType.text,
                        prefixIcon: Icons.design_services,
                        myController: controller.serviceName,
                        valid: (val) {
                          return validInput(val!, 6, 200, "any");
                        },
                      ),
                      CustomTextFormAuth(
                        hintText: "Time (15)",
                        type: TextInputType.number,
                        prefixIcon: Icons.timer,
                        myController: controller.serviceTime,
                        valid: (val) {
                          return validInput(val!, 1, 3, "any");
                        },
                      ),
                      CustomTextFormAuth(
                        hintText: "Price (50)",
                        type: const TextInputType.numberWithOptions(
                            decimal: true),
                        prefixIcon: Icons.price_change,
                        myController: controller.servicePrice,
                        valid: (val) {
                          return validInput(val!, 1, 4, "any");
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
                          text: "Select Image",
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: controller.statusRequest == StatusRequest.loading
                            ? const CupertinoActivityIndicator()
                            : CustomButtonAuth(
                                onPressed: () {
                                  controller.addServicesData();
                                },
                                text: "Add Service",
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
