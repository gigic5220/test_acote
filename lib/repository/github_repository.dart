import 'package:get/get.dart';
import 'package:test_acote/provider/github_api.dart';

class GithubRepository extends GetxService {
  final GithubApi githubApi;

  GithubRepository({
    required this.githubApi
  });

  getUserList() async => await githubApi.getUserList();
}