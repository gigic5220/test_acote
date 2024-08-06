import 'package:get/get.dart';
import 'package:test_acote/controller/HomePageController.dart';
import 'package:test_acote/provider/github_api.dart';
import 'package:test_acote/repository/github_repository.dart';

class HomePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomePageController>(() => HomePageController(githubRepository: GithubRepository(githubApi: GithubApi())));
  }
}