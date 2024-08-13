import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_acote/controller/DetailPageController.dart';
import 'package:test_acote/layout/custom_appbar.dart';
import 'package:test_acote/model/repository.dart';
import 'package:test_acote/widget/common/common_paging_loading_widget.dart';
import 'package:test_acote/widget/common/loading_spinner_widget.dart';
import 'package:test_acote/widget/detail_page/user_repository_list_widget.dart';

class DetailPage extends GetView<DetailPageController> {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.getUserName ?? '',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              '리포지토리',
              style: TextStyle(
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          Obx(() {
            if (controller.getIsInitialDataLoading) {
              return const Center(
                child: LoadingSpinnerWidget(),
              );
            } else {
              return Obx(() {
                if (controller.getUserRepositoryList.isNotEmpty) {
                  return UserRepositoryListWidget(
                    scrollController: controller.scrollController,
                    userRepositoryList: controller.getUserRepositoryList
                  );
                } else {
                  return const Center(
                    child: Text(
                      '리포지토리가 존재하지 않습니다',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400
                      ),
                    )
                  );
                }
              });
            }
          }),
          Positioned(
            left: 0,
            right: 0,
            bottom: 30,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Obx(() {
                if (!controller.getIsInitialDataLoading && controller.getIsUserRepositoryListLoading) {
                  return const CommonPagingLoadingWidget();
                } else {
                  return Container();
                }
              })
            )
          )
        ]
      )
    );
  }
}