import 'package:get/get.dart';

class GithubApi extends GetConnect {
  Future<List<dynamic>> getUserList({
    int? sincePagingParameter
  }) async {
    final Response response = await get('https://api.github.com/users${sincePagingParameter != null ? '?since=$sincePagingParameter' : ''}');
    if (response.hasError) {
      return [];
    } else {
      return response.body;
    }
  }

  Future<List<dynamic>> getUserRepositoryList({
    required String userName,
    int? pagePagingParameter = 1
  }) async {
    final Response response = await get('https://api.github.com/users/$userName/repos?page=$pagePagingParameter');
    if (response.hasError) {
      return [];
    } else {
      return response.body;
    }
  }
}