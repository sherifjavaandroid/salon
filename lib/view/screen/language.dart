import 'package:easycut_business/core/localization/change_local.dart';
import 'package:easycut_business/view/widget/language/custom_button_lang.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Language extends GetView<LocalController> {
  const Language({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '1'.tr,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 20),
            // CustomButtonLang(
            //   textButton: '2'.tr,
            //   onPressed: () {
            //     controller.changeLang('ar');
            //   },
            // ),
            CustomButtonLang(
              textButton: '3'.tr,
              onPressed: () {
                controller.changeLang('en');
              },
            ),
            // CustomButtonLang(
            //   textButton: '4'.tr,
            //   onPressed: () {
            //     controller.changeLang('de');
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
