import 'package:flutter/material.dart';
import 'package:tb_clinic/utils/config/app_text.dart';

PreferredSizeWidget buildAppBar(BuildContext context, String title) {
  return AppBar(
    centerTitle: true,
    toolbarHeight: 70,
    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    title: Text(
      title,
      style: TextStyle(fontFamily: AppText().primaryFont),
    ),
  );
}
