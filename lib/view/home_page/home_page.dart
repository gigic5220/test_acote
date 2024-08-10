import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_acote/controller/HomePageController.dart';
import 'package:test_acote/model/user.dart';
import 'package:test_acote/widget/common/custom_cached_network_image_widget.dart';

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
        child: Obx(() {
          return ListView.builder(
            controller: controller.scrollController,
            itemBuilder: (context, index) => _userListItem(
              user: controller.getUserList[index],
              userListItemIndex: index,
              adBannerLocationIndex: controller.getAdBannerLocationIndex,
              adBannerImageUrl: controller.getAdBannerImageUrl(),
              onTapUserItem: () => controller.onTapUserItem(userId: controller.getUserList[index].id),
              onTapAdBanner: () => controller.onTapAdBanner(targetUrl: controller.getAdBannerBrowserTargetUrl())
            ),
            itemCount: controller.getUserList.length
          );
        })
      )
    );
  }

  Widget _userListItem({
    required User user,
    required int userListItemIndex,
    required int adBannerLocationIndex,
    required String adBannerImageUrl,
    required void Function() onTapUserItem,
    required void Function() onTapAdBanner
  }) {
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTapUserItem,
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                ClipOval(
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: CustomCachedNetworkImageWidget(
                      imageUrl: user.avatarUrl,
                    )
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
            ),
          ),
        ),
        if ((userListItemIndex + 1) % adBannerLocationIndex == 0) ...[
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: _adBannerWidget(
              onTapAdBanner: onTapAdBanner,
              bannerUrl: adBannerImageUrl
            )
          )
        ]
      ],
    );
  }

  Widget _adBannerWidget({
    required String bannerUrl,
    required void Function() onTapAdBanner
  }) {
    final double imageRatio = 100 / 500;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth;
        return GestureDetector(
          onTap: onTapAdBanner,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: maxWidth,
            height: maxWidth * imageRatio,
            child: CustomCachedNetworkImageWidget(
              imageUrl: bannerUrl,
            )
          )
        );
      }
    );
  }
}