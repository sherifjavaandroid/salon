import 'package:easycut_business/app.dart';
import 'package:easycut_business/core/constant/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BigText extends StatelessWidget {
  const BigText({
    Key? key,
    required this.text,
    this.color = Colors.black,
    this.textAlign = TextAlign.center,
    this.overFlow = TextOverflow.ellipsis,
    this.fontFamily,
    this.fontWeight = FontWeight.w700,
    this.size = 0,
  }) : super(key: key);

  final String text;
  final Color? color;
  final double size;
  final TextOverflow overFlow;
  final TextAlign textAlign;
  final String? fontFamily;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overFlow,
      maxLines: 1,
      style: TextStyle(
        fontFamily: fontFamily,
        color: color,
        fontSize: size == 0 ? Dimensions.font20.sp : size.sp,
        fontWeight: fontWeight,
      ),
    );
  }
}
