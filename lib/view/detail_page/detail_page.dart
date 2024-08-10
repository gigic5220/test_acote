import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_acote/controller/DetailPageController.dart';
import 'package:test_acote/layout/custom_appbar.dart';

class DetailPage extends GetView<DetailPageController> {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: '리포지토리',
      ),
      body: Container(),
    );
  }
}