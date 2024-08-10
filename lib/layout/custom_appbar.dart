import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget{
  final String title;

  const CustomAppbar({
    super.key,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    final int depth = max(0, Get.currentRoute.split('/').length - 1);
    return AppBar(
      leading: depth > 1 ?
        IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 20,
            semanticLabel: 'page back button icon',
          ),
          onPressed: Get.back,
        ) : null,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
}

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
