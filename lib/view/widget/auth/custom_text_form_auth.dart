import 'package:easycut_business/core/constant/color.dart';
import 'package:easycut_business/core/constant/dimensions.dart';
import 'package:flutter/material.dart';

class CustomTextFormAuth extends StatelessWidget {
  final String hintText;
  final TextInputType type;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController myController;
  final bool obSecure;
  final void Function()? suffixPressed;
  final String? Function(String?)? valid;

  const CustomTextFormAuth({
    Key? key,
    required this.hintText,
    required this.type,
    required this.prefixIcon,
    this.suffixIcon,
    required this.myController,
    this.obSecure = false,
    this.suffixPressed,
    required this.valid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: myController,
        keyboardType: type,
        obscureText: obSecure,
        validator: valid,
        autocorrect: false,
        style: const TextStyle(
          color: AppColor.primaryColor,
        ),
        decoration: InputDecoration(
          // filled: true,
          // fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              Dimensions.radius20,
            ),
          ),
          hintText: hintText,
          prefixIcon: Icon(
            prefixIcon,
            color: AppColor.primaryColor,
          ),
          suffixIcon: InkWell(
            onTap: suffixPressed,
            child: Icon(
              suffixIcon,
              color: AppColor.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
