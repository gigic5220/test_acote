import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_acote/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/home',
      getPages: AppPages.pages
    );
  }
}