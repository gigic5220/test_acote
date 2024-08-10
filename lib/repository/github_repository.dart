import 'package:get/get.dart';
import 'package:test_acote/model/user.dart';
import 'package:test_acote/provider/github_api.dart';

class GithubRepository extends GetxService {
  final GithubApi githubApi;

  GithubRepository({
    required this.githubApi
  });

  Future<List<User>> getUserList({
    int? sincePagingParameter
  }) async {
    final List<dynamic> userListJson =  await githubApi.getUserList(sincePagingParameter: sincePagingParameter);
    return userListJson.map((json) => User.fromJson(json)).toList();
  }
}