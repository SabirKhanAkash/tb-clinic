import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tb_clinic/ui/shared/components/custom_text_form_field_one.dart';
import 'package:tb_clinic/utils/config/app_color.dart';
import 'package:tb_clinic/utils/config/app_image.dart';
import 'package:tb_clinic/utils/config/app_style.dart';
import 'package:tb_clinic/utils/config/app_text.dart';
import 'package:tb_clinic/utils/helpers/random_generator_helper.dart';

class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  final TextEditingController patientSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: CustomTextFormFieldOne(
                controller: patientSearchController,
                maxLines: 1,
                keyboardType: TextInputType.name,
                hintText: AppText().searchPatientHint,
                prefixIconVisibility: true,
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 55,
                  padding: const EdgeInsets.all(10),
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final recoveryStatus = RandomGeneratorHelper().generateRandomRecoveryStatus();
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColor().veryLightPurple,
                        borderRadius: BorderRadius.circular(AppStyle().verySmallDp),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
                      child: ListTile(
                        title: Text(
                          RandomGeneratorHelper().generateRandomName(),
                          style: TextStyle(
                            fontSize: AppStyle().largeDp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          RandomGeneratorHelper().generateRandomDisease(),
                          style: TextStyle(
                            fontSize: AppStyle().smallDp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        leading: Image.network(
                          "${AppImage().dp}${index + Random().nextInt(30)}",
                          height: 65,
                          width: 65,
                          filterQuality: FilterQuality.low,
                        ),
                        trailing: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              RandomGeneratorHelper().generateRandomTime(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: AppStyle().verySmallDp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              recoveryStatus,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: AppStyle().verySmallDp,
                                color: recoveryStatus == AppText().recoveredStatus
                                    ? AppColor().green
                                    : recoveryStatus == AppText().followUpStatus
                                        ? AppColor().yellow
                                        : AppColor().blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        style: ListTileStyle.drawer,
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
