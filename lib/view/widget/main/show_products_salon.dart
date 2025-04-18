import 'package:easycut_business/app.dart';
import 'package:easycut_business/core/constant/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowProductsSalon extends StatelessWidget {
  const ShowProductsSalon({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constr) {
        return SizedBox(
          height: constr.maxHeight.h,
          width: constr.maxWidth.w,
          child: GridView.builder(
            padding: EdgeInsets.symmetric(
              vertical: Dimensions.height20.h,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: Dimensions.height15.h,
              crossAxisSpacing: Dimensions.height15.h,
              childAspectRatio: 3 / 4,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Container(
                color: Colors.red,
              );
            },
          ),
        );
      },
    );
  }
}
