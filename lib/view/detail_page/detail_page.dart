import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_acote/controller/DetailPageController.dart';
import 'package:test_acote/layout/custom_appbar.dart';
import 'package:test_acote/model/repository.dart';
import 'package:test_acote/widget/common/common_paging_loading_widget.dart';
import 'package:test_acote/widget/common/loading_spinner_widget.dart';

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
              return ListView.separated(
                controller: controller.scrollController,
                itemBuilder: (context, index) => _repositoryListItem(
                  repository: controller.getUserRepositoryList[index],
                ),
                separatorBuilder: (context, index) => Container(
                  height: 0.5,
                  color: Colors.grey
                ),
                itemCount: controller.getUserRepositoryList.length
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

  Widget _repositoryListItem({
    required Repository repository,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 14),
          Text(
            repository.name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700
            ),
          ),
          const SizedBox(height: 4),
          if (repository.description != null) ...[
            Text(
              repository.description!,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54
              ),
            ),
            const SizedBox(height: 4),
          ],
          Row(
            children: [
              const Icon(
                Icons.star,
                color: Colors.yellow,
                size: 20,
                semanticLabel: 'user repository star count',
              ),
              const SizedBox(width: 4),
              Text(
                repository.stargazersCount.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54
                ),
              ),
              const SizedBox(width: 15),
              if (repository.language != null) ...[
                Text(
                  repository.language!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54
                  ),
                ),
              ]
            ],
          ),
          const SizedBox(height: 14)
        ]
      )
    );
  }
}