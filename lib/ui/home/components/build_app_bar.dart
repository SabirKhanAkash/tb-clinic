import 'package:flutter/material.dart';
import 'package:tb_clinic/utils/config/app_color.dart';

PreferredSizeWidget buildAppBar(BuildContext context, String? dp, String? userName) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(125),
    child: ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: AppBar(
        centerTitle: false,
        toolbarHeight: 125,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: <Color>[
                AppColor().lightPurple, // Start color of the gradient
                AppColor().darkPurple, // End color of the gradient
              ],
            ),
          ),
        ),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 1, color: AppColor().white),
                bottom: BorderSide(width: 1, color: AppColor().white),
                left: BorderSide(width: 1, color: AppColor().white),
                right: BorderSide(width: 1, color: AppColor().white),
              ),
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(dp ?? ""),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome!",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColor().white),
            ),
            Text(
              userName ?? "",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontSize: 18, color: AppColor().white),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: () {
                // Add your search function here
              },
              icon: Icon(
                Icons.search,
                color: AppColor().white,
                size: 35,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
