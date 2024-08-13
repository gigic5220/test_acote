import 'package:flutter/material.dart';
import 'package:test_acote/model/user.dart';
import 'package:test_acote/widget/common/custom_cached_network_image_widget.dart';

class UserListWidget extends StatelessWidget {
  final ScrollController scrollController;
  final List<User> userList;
  final int adBannerLocationIndex;
  final String adBannerImageUrl;
  final void Function({required int index}) onTapUserItem;
  final void Function() onTapAdBanner;

  const UserListWidget({
    super.key,
    required this.scrollController,
    required this.userList,
    required this.adBannerLocationIndex,
    required this.adBannerImageUrl,
    required this.onTapUserItem,
    required this.onTapAdBanner,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      controller: scrollController,
      itemBuilder: (context, index) => _userListItem(
        user: userList[index],
        userListItemIndex: index,
        adBannerLocationIndex: adBannerLocationIndex,
        adBannerImageUrl: adBannerImageUrl,
        onTapUserItem: () => onTapUserItem(index: index),
        onTapAdBanner: onTapAdBanner
      ),
      itemCount: userList.length
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
            key: Key('test_key_ad_banner_$userListItemIndex'),
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