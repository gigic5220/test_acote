import 'package:get/get.dart';
import 'package:test_acote/repository/github_repository.dart';

class HomePageController extends GetxController {
  final GithubRepository githubRepository;
  HomePageController({
    required this.githubRepository
  });

  @override
  void onInit() async {
    super.onInit();
  }
}