import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_acote/model/repository.dart';

class UserRepositoryListWidget extends StatelessWidget {
  final ScrollController scrollController;
  final List<Repository> userRepositoryList;

  const UserRepositoryListWidget({
    super.key,
    required this.scrollController,
    required this.userRepositoryList
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      itemBuilder: (context, index) => _repositoryListItem(
        repository: userRepositoryList[index],
        index: index
      ),
      separatorBuilder: (context, index) => Container(
        height: 0.5,
        color: Colors.grey
      ),
      itemCount: userRepositoryList.length
    );
  }

  Widget _repositoryListItem({
    required Repository repository,
    required int index
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 14),
          Text(
            key: Key('test_key_text_widget_name_$index'),
            repository.name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700
            ),
          ),
          const SizedBox(height: 4),
          if (repository.description != null) ...[
            Text(
              key: Key('test_key_text_widget_description_$index'),
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
                key: Key('test_key_text_widget_stargazers_count_$index'),
                repository.stargazersCount.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54
                ),
              ),
              const SizedBox(width: 15),
              if (repository.language != null) ...[
                Text(
                  key: Key('test_key_text_widget_language_$index'),
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