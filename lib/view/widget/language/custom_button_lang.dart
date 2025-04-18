import 'package:easycut_business/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomButtonLang extends StatelessWidget {
  final String textButton;
  final void Function()? onPressed;
  const CustomButtonLang({
    super.key,
    required this.textButton,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      width: double.infinity,
      child: MaterialButton(
        onPressed: onPressed,
        color: AppColor.primaryColor,
        textColor: Colors.white,
        child: Text(
          textButton,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
