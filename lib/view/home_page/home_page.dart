import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_acote/controller/HomePageController.dart';
import 'package:test_acote/layout/custom_appbar.dart';
import 'package:test_acote/widget/common/common_paging_loading_widget.dart';
import 'package:test_acote/widget/common/loading_spinner_widget.dart';
import 'package:test_acote/widget/home_page/user_list_widget.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: '사용자 목록'
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Stack(
          children: [
            Obx(() {
              if (controller.getIsInitialDataLoading) {
                return const Center(
                  child: LoadingSpinnerWidget(),
                );
              } else {
                return UserListWidget(
                  scrollController: controller.scrollController,
                  userList: controller.getUserList,
                  adBannerLocationIndex: controller.getAdBannerLocationIndex,
                  adBannerImageUrl: controller.getAdBannerImageUrl(),
                  onTapUserItem: ({required int index}) => controller.onTapUserItem(userName: controller.getUserList[index].login),
                  onTapAdBanner: () => controller.onTapAdBanner(targetUrl: controller.getAdBannerBrowserTargetUrl())
                );
              }
            }),
            Positioned(
              left: 0,
              right: 0,
              bottom: 30,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Obx(() {
                  if (!controller.getIsInitialDataLoading && controller.getIsUserListLoading) {
                    return const CommonPagingLoadingWidget();
                  } else {
                    return Container();
                  }
                })
              )
            )
          ],
        )
      )
    );
  }
}