import 'package:flutter/material.dart';
import 'package:tb_clinic/ui/home/screens/home_screen.dart';
import 'package:tb_clinic/ui/shared/components/custom_elevated_button_one.dart';
import 'package:tb_clinic/utils/config/app_color.dart';
import 'package:tb_clinic/utils/config/app_text.dart';

Widget buildMessageBody(BuildContext context) {
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
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: <Color>[
                            AppColor().moreLightPurple,
                            AppColor().darkPurple,
                          ],
                        ),
                      ),
                      child: CustomElevatedButtonOne(
                        buttonLabel: AppText().messageButtonTextOne,
                        backgroundColor: AppColor().red,
                        foregroundColor: AppColor().white,
                        buttonClickAction: () => Navigator.push(
                            context, MaterialPageRoute(builder: (context) => HomeScreen())),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: <Color>[
                            AppColor().moreLightPurple,
                            AppColor().darkPurple,
                          ],
                        ),
                      ),
                      child: CustomElevatedButtonOne(
                        buttonLabel: AppText().messageButtonTextTwo,
                        backgroundColor: AppColor().purple,
                        foregroundColor: AppColor().white,
                        buttonClickAction: () => Navigator.push(
                            context, MaterialPageRoute(builder: (context) => HomeScreen())),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: <Color>[
                            AppColor().moreLightPurple, // Start color of the gradient
                            AppColor().darkPurple, // End color of the gradient
                          ],
                        ),
                      ),
                      child: CustomElevatedButtonOne(
                        buttonLabel: AppText().messageButtonTextThree,
                        backgroundColor: AppColor().purple,
                        foregroundColor: AppColor().white,
                        buttonClickAction: () => Navigator.push(
                            context, MaterialPageRoute(builder: (context) => HomeScreen())),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: <Color>[
                            AppColor().moreLightPurple,
                            AppColor().darkPurple,
                          ],
                        ),
                      ),
                      child: CustomElevatedButtonOne(
                        buttonLabel: AppText().messageButtonTextFour,
                        backgroundColor: AppColor().purple,
                        foregroundColor: AppColor().white,
                        buttonClickAction: () => Navigator.push(
                            context, MaterialPageRoute(builder: (context) => HomeScreen())),
                      ),
                    ),
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
