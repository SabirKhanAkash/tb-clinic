import 'package:flutter/material.dart';
import 'package:tb_clinic/ui/shared/components/custom_elevated_button_one.dart';
import 'package:tb_clinic/ui/shared/components/custom_text_form_field_one.dart';
import 'package:tb_clinic/utils/config/app_color.dart';
import 'package:tb_clinic/utils/config/app_image.dart';
import 'package:tb_clinic/utils/config/app_style.dart';
import 'package:tb_clinic/utils/config/app_text.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController diseasesController = TextEditingController();
  final TextEditingController diagnosisNoteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3.5,
                      height: MediaQuery.of(context).size.width / 3.5,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(AppImage().dp),
                        ),
                        border: Border(
                          top: BorderSide(width: 2, color: AppColor().moreDarkPurple),
                          bottom: BorderSide(width: 2, color: AppColor().moreDarkPurple),
                          left: BorderSide(width: 2, color: AppColor().moreDarkPurple),
                          right: BorderSide(width: 2, color: AppColor().moreDarkPurple),
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40, top: 12, bottom: 5),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        AppText().name,
                        style: TextStyle(fontSize: AppStyle().largeDp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Age: ${AppText().age}",
                        style:
                            TextStyle(fontSize: AppStyle().mediumDp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Text(
                        AppText().profileHeadingOne,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColor().borderColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: CustomTextFormFieldOne(
                      controller: nameController,
                      maxLines: 1,
                      keyboardType: TextInputType.name,
                      hintText: AppText().profileHintOne,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Text(
                        AppText().profileHeadingTwo,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColor().borderColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: CustomTextFormFieldOne(
                      controller: phoneNoController,
                      maxLines: 1,
                      keyboardType: TextInputType.phone,
                      hintText: AppText().profileHintTwo,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Text(
                        AppText().profileHeadingThree,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColor().borderColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: CustomTextFormFieldOne(
                      controller: diseasesController,
                      maxLines: 4,
                      keyboardType: TextInputType.text,
                      hintText: AppText().profileHintThree,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Text(
                        AppText().profileHeadingFour,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColor().borderColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: CustomTextFormFieldOne(
                      controller: diagnosisNoteController,
                      maxLines: 4,
                      keyboardType: TextInputType.text,
                      hintText: AppText().profileHintFour,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 15),
                    child: CustomElevatedButtonOne(
                      buttonLabel: AppText().updateProfileButtonText,
                      backgroundColor: AppColor().red,
                      foregroundColor: AppColor().white,
                      buttonClickAction: () async => (),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
