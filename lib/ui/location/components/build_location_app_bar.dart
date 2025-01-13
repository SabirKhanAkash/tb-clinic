import 'package:flutter/material.dart';

PreferredSizeWidget buildLocationAppBar() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(80),
    child: Visibility(
      visible: false,
      child: AppBar(
        title: const Text(""),
      ),
    ),
  );
}
