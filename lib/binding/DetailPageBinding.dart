import 'package:get/get.dart';
import 'package:test_acote/controller/DetailPageController.dart';
import 'package:test_acote/provider/github_api.dart';
import 'package:test_acote/repository/github_repository.dart';

class DetailPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPageController>(() => DetailPageController(githubRepository: GithubRepository(githubApi: GithubApi())));
  }
}