import 'package:flutter/material.dart';
import 'package:tb_clinic/utils/config/app_color.dart';
import 'package:tb_clinic/utils/config/app_style.dart';
import 'package:tb_clinic/utils/config/app_text.dart';

PreferredSizeWidget buildMessageAppBar() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(80),
    child: ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          AppText().chatAppBarLabel,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
              fontSize: AppStyle().veryLargeDp,
              fontWeight: FontWeight.w600,
              color: AppColor().moreDarkPurple),
        ),
      ),
    ),
  );
}
