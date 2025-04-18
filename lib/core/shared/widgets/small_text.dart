import 'package:easycut_business/core/constant/dimensions.dart';
import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  const SmallText({
    Key? key,
    this.color = Colors.black,
    required this.text,
    this.textAlign = TextAlign.center,
    this.overFlow = TextOverflow.ellipsis,
    this.fontFamily,
    this.fontWeight = FontWeight.w400,
    this.size = 0,
    this.height = 1.2,
  }) : super(key: key);

  final String text;
  final Color? color;
  final double size;
  final double height;
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
      style: TextStyle(
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        color: color,
        fontSize: size == 0 ? Dimensions.font16 : size,
        height: height,
      ),
    );
  }
}
