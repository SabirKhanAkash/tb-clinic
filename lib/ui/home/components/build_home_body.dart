import 'package:flutter/material.dart';
import 'package:tb_clinic/ui/home/screens/home_screen.dart';
import 'package:tb_clinic/ui/shared/components/custom_elevated_button_one.dart';
import 'package:tb_clinic/utils/config/app_color.dart';
import 'package:tb_clinic/utils/config/app_text.dart';

Widget buildHomeBody(BuildContext context) {
  return SafeArea(
    child: Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                  child: CustomElevatedButtonOne(
                    buttonLabel: AppText().homeButtonTextOne,
                    backgroundColor: AppColor().red,
                    foregroundColor: AppColor().white,
                    buttonClickAction: () => Navigator.push(
                        context, MaterialPageRoute(builder: (context) => HomeScreen())),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                  child: CustomElevatedButtonOne(
                    buttonLabel: AppText().homeButtonTextTwo,
                    backgroundColor: AppColor().purple,
                    foregroundColor: AppColor().white,
                    buttonClickAction: () => Navigator.push(
                        context, MaterialPageRoute(builder: (context) => HomeScreen())),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                  child: CustomElevatedButtonOne(
                    buttonLabel: AppText().locationLabel,
                    backgroundColor: AppColor().purple,
                    foregroundColor: AppColor().white,
                    buttonClickAction: () => Navigator.push(
                        context, MaterialPageRoute(builder: (context) => HomeScreen())),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                  child: CustomElevatedButtonOne(
                    buttonLabel: AppText().homeButtonTextFour,
                    backgroundColor: AppColor().purple,
                    foregroundColor: AppColor().white,
                    buttonClickAction: () => Navigator.push(
                        context, MaterialPageRoute(builder: (context) => HomeScreen())),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
