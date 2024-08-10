import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_acote/controller/HomePageController.dart';
import 'package:test_acote/model/user.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '사용자 목록',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView.separated(
          itemBuilder: (context, index) => _userListItem(user: controller.getUserList[index]),
          separatorBuilder: (context, index) {
            if ((index + 1) % controller.getAdBannerIndex == 0) {
              return _adBannerWidget(bannerUrl: controller.getAdBannerUrl());
            } else {
              return const SizedBox(height: 20);
            }
          },
          itemCount: controller.getUserList.length
        )
      )
    );
  }

  Widget _userListItem({
    required User user
  }) {
    return Row(
      children: [
        ClipOval(
          child: SizedBox(
            width: 40,
            height: 40,
            child: Image.network(
              user.avatarUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 15),
        Column(
          children: [
            Text(
              user.login,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _adBannerWidget({
    required String bannerUrl
  }) {
    final double imageRatio = 100 / 500;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth;
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          width: maxWidth,
          height: maxWidth * imageRatio,
          child: Image.network(
            bannerUrl,
            fit: BoxFit.cover,
          )
        );
      }
    );
  }
}